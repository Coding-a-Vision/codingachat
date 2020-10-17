//
//  AppCoordinator.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    private let tracker = FakeTracker()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        if let user = Auth.auth().currentUser {
            
            let homeCoordinator = HomeCoordinator(window: window, user: user, tracker: tracker)
            homeCoordinator.start()
            childCoordinators.append(homeCoordinator)
            
        } else {
            let loginCoordinator = LoginCoordinator(window: window, tracker: tracker)
            
            loginCoordinator.onLogin = { [weak self] user in
                self?.start()
            }
            
            loginCoordinator.start()
            childCoordinators.append(loginCoordinator)
        }
    }
    func goToChannel(_ channel: Channel) {
        
        guard let user = Auth.auth().currentUser , let presenter = UIApplication.topViewController() else { return }
        
        let chatCoordinator = ChatCoordinator(presenter: presenter, channel: channel, user: user)
        chatCoordinator.start()
        childCoordinators.append(chatCoordinator)
        
    }
    
}
