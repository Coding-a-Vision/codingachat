//
//  ColorsCoordinator.swift
//  CodingAChat
//
//  Created by Alex on 19/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class BackgroundsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigator: UINavigationController
    let viewController: BackgroundsViewController
    private let window: UIWindow
    private let number: Int
    
    init(window: UIWindow, number: Int) {
        self.window = window
        self.number = number
        self.viewController = BackgroundsViewController(selected: number)
        self.navigator = WhiteNavigationController(rootViewController: viewController)
    }
    
    func start() {
        viewController.delegate = self
        window.rootViewController = navigator
    }
}

extension BackgroundsCoordinator: ColorsViewActionDelegate {
    func changeBg(withSelected selected: Int) {
        
    }
    
}
