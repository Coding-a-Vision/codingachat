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

class ChatCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let presenter: UIViewController
    private let chatViewController : ChatViewController
    private let window : UIWindow
    private let db: Firestore
    private let user: User
    private let channel: Channel
    var bombSoundEffect: AVAudioPlayer?
    

    
    
    init(presenter: UIViewController, window: UIWindow, channel : Channel, user: User) {
        self.user = user
        self.presenter = presenter
        self.window = window
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
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                
                guard let querySnapshot = querySnapshot else { return print("No documents") }
                self?.playSound()
                
                querySnapshot.documentChanges.forEach { diff in
                    
                    if diff.type == .added,
                       let timestamp = diff.document.get("data") as? Timestamp,
                       let message = Message(json: diff.document.data(), id: diff.document.documentID, date: timestamp.dateValue()) {
                        self?.chatViewController.addMessage(message)
                    } else if diff.type == .removed {
                        let id = diff.document.documentID
                        // self?.chatViewController.removeMessage(withId: id) // TODO:
                    }
                }
            }
    }
}

extension ChatCoordinator: ChatViewControllerDelegate {
    
    func sendImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        
        let storage = FirebaseStorageServices()
        let imageName = UUID().uuidString
        
        SVProgressHUD.show(withStatus: "Wait...")
        
        firstly {
            storage.uploadImage(data, imageName: "\(imageName).jpg")
        }.done { url in
            self.sendMessage(message: nil, url: url, type: .photo)
        }.ensure {
            SVProgressHUD.dismiss()
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
    func playSound(){
        let path = Bundle.main.path(forResource: "sound", ofType: "mp3")
        if let path = path {
        let url = URL(fileURLWithPath: path)
            do {
                bombSoundEffect = try AVAudioPlayer(contentsOf: url)
                bombSoundEffect?.play()
            }catch{
                print(error)
            }
        }
    }
}


