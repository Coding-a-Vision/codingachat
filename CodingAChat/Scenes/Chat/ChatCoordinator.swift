//
//  ChatCoordinator.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 06/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import PromiseKit
import SVProgressHUD
import AVFoundation
import FirebaseMessaging

class ChatCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let presenter: UIViewController
    private let chatViewController: ChatViewController
    private let db: Firestore
    private let user: User
    private let channel: Channel
    var alertSound: AVAudioPlayer?
    var isFirstLoading = true
    
    init(presenter: UIViewController, channel: Channel, user: User) {
        self.user = user
        self.presenter = presenter
        self.chatViewController = ChatViewController(channel: channel, user: user)
        self.db = Firestore.firestore()
        self.channel = channel
    }
    
    func start() {
        chatViewController.delegate = self
        presenter.navigationController?.pushViewController(chatViewController, animated: true)
        getMessages()
    }
    
    func getMessages() {
        
        db.collection("channels")
            .document(channel.id)
            .collection("messages")
            .addSnapshotListener { [weak self] (querySnapshot, _) in
                
                guard let querySnapshot = querySnapshot else { return print("No documents") }
                
                if !(self?.isFirstLoading ?? true) {
                    self?.playSound()
                }
                
                self?.isFirstLoading = false
                
                querySnapshot.documentChanges.forEach { diff in
                    
                    if diff.type == .added,
                       let timestamp = diff.document.get("data") as? Timestamp,
                       let message = Message(json: diff.document.data(), id: diff.document.documentID, date: timestamp.dateValue()) {
                        self?.chatViewController.addMessage(message)
                    } else if diff.type == .removed {
                        _ = diff.document.documentID
                        // self?.chatViewController.removeMessage(withId: id)
                    }
                }
            }
    }
}

extension ChatCoordinator: ChatViewControllerDelegate {
 
    func toggleNotification() {
        
        // Se sono registrato faccio l'unsubscribe
        let notificationChannelId = Constants.getNotificationChannelID(from: channel.name)
        
        if UserDefaults.standard.bool(forKey: notificationChannelId) {
            Messaging.messaging().unsubscribe(fromTopic: channel.name)
            UserDefaults.standard.set(false, forKey: notificationChannelId)
        } else {
            Messaging.messaging().subscribe(toTopic: channel.name)
            UserDefaults.standard.set(true, forKey: notificationChannelId)
        }
        
        chatViewController.setNotificationIcon()
        
    }
    
    func sendImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        
        let storage = FirebaseStorageServices()
        let imageName = UUID().uuidString
        
        UIViewController.showHUD(message: "Wait...")
        
        firstly {
            storage.uploadImage(data, imageName: "\(imageName).jpg")
        }.done { url in
            self.sendMessage(message: nil, url: url, type: .photo)
        }.ensure {
            UIViewController.dismissHUD()
        }.catch { error in
            UIAlertController.show(message: "Error: \(error.localizedDescription)")
        }
    }
    
    func sendMessage(message: String?, url: URL?, type: Type) {
        guard let name = user.displayName, let id = Auth.auth().currentUser?.uid else {
            UIAlertController.show(title: "Unable to send messages", message: "Please set your name and your image first")
            return
        }
        
        let timestamp = Timestamp()
        
        var body: [String: Any] = [
            "author": name,
            "authorId": id,
            "kind": type.rawValue,
            "userPictureUrl": user.photoURL?.absoluteString ?? "",
            "data": timestamp
        ]
        
        if let message = message {
            body["message"] = message
        } else if let url = url {
            body["pictureUrl"] = url.absoluteString
        }
        
        db.collection("channels")
            .document(chatViewController.channel.id)
            .collection("messages").addDocument(data: body)
    }
    
    private func playSound() {
        let path = Bundle.main.path(forResource: "sound", ofType: "mp3")
        if let path = path {
        let url = URL(fileURLWithPath: path)
            do {
                alertSound = try AVAudioPlayer(contentsOf: url)
                alertSound?.play()
            } catch {
                print(error)
            }
        }
    }
}
