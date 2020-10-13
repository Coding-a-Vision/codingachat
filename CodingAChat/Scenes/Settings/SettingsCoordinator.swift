//
//  SettingsCoordinator.swift
//  CodingAChat
//
//  Created by Marco Caliò on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
class SettingsCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    private let viewController : SettingsViewController
    private let window : UIWindow
    private let presenter : UIViewController
    
    init(window : UIWindow, presenter : UIViewController) {
        self.window=window
        self.presenter=presenter
        viewController = SettingsViewController()
    }
    
    func start() {
        viewController.delegate=self
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SettingsCoordinator : settingsActionDelegate {

    func contactUs() {
       print("toimpl")
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        let appcoordinator = AppCoordinator(window: window)
        appcoordinator.start()
    }
}

