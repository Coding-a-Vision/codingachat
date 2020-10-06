//
//  ChatCoordinator.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 06/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation

class ChatCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let chatViewController: ChatViewController
    
    init() {
        self.chatViewController = ChatViewController()
        chatViewController.delegate = self
    }
    
    func start() {
        //start
    }
    
}

extension ChatCoordinator: ChatViewControllerDelegate {
    
    func sendMessage(message: String) {
        
        print("Send message: \(message)")
    }
    
    
}
