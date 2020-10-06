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
    private let viewController : ChatViewController
    private let window : UIWindow
    
    init(presenter: UIViewController, window: UIWindow, channel : Channel) {
        self.presenter = presenter
        self.window=window
        self.viewController = ChatViewController(channel: channel)
    }
    
    func start() {
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
