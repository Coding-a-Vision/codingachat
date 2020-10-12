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

class ChatCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let presenter: UIViewController
    private let chatViewController : ChatViewController
    private let window : UIWindow
    private let db: Firestore
    private let user: User
    private let channel: Channel
    
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
    
    func sendMessage(message: String, type: Type) {
        guard let name = user.displayName, let id = Auth.auth().currentUser?.uid else {
            UIAlertController.show("Unable to send messages", from: self.chatViewController)
            print("User without name")
            return
        }
        
        let timestamp = Timestamp()
        
        db.collection("channels")
            .document(chatViewController.channel.id)
            .collection("messages").addDocument(data: [
                "author": name,
                "authorId": id,
                "message": message,
                "kind": type.rawValue,
                "userPictureUrl": user.photoURL?.absoluteString ?? "",
                "data": timestamp
            ])
        
    }
}
