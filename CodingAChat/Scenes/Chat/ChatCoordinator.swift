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
        self.chatViewController = ChatViewController(channel: channel)
        self.db = Firestore.firestore()
        self.channel = channel
    }
    
    func start() {
        chatViewController.delegate = self
        presenter.navigationController?.pushViewController(chatViewController, animated: true)
        getMessages()
    }
    
    func getMessages() {
     db.collection("channels").document(channel.id).collection("messages").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { return print("No documents") }
            
            let messages = documents
            .compactMap { Message(json: $0.data()) }
                .sorted { $0.message < $1.message }
            
        self?.chatViewController.messages = Set(messages)        }
    }
}


extension ChatCoordinator: ChatViewControllerDelegate {
    
    func sendMessage(message: String) {
        guard let name = user.displayName else { return print("User without name") }
        
        let timestamp = Timestamp()
        
        db.collection("channels").document(chatViewController.channel.id).collection("messages").addDocument(data: [
            "author": name,
            "message": message,
            "data": timestamp
        ])
        chatViewController.messageTextField.text = nil
    }
    
}
