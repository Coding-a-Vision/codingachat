//
//  ChatCoordinator.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 06/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class ChatCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []

    private let presenter: UIViewController
    private let chatViewController : ChatViewController
    private let window : UIWindow
    
    init(presenter: UIViewController, window: UIWindow, channel : Channel) {
        self.presenter = presenter
        self.window=window
        self.chatViewController = ChatViewController(channel: channel)
        
    }
    
    func start() {
        chatViewController.delegate = self
        presenter.navigationController?.pushViewController(chatViewController, animated: true)
    }
    
}

extension ChatCoordinator: ChatViewControllerDelegate {
    
    func sendMessage(message: String) {
        
        print("Send message: \(message)")
    }
    
    
}
