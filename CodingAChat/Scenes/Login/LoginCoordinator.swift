//
//  LoginCoordinator.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let loginViewController: LoginViewController
    private let window: UIWindow
    private let tracker: Trackable
    var onLogin: ((User) -> Void)?
    
    init(window: UIWindow, tracker: Trackable) {
        self.window = window
        self.tracker = tracker
        self.loginViewController = LoginViewController()
    }
    
    func start() {
        loginViewController.delegate = self
        window.rootViewController = loginViewController
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    
    func onLogin(withEmail email: String, andPassword password: String) {
        
        UIViewController.showHUD(message: "generics.hud.wait".localized)
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            UIViewController.dismissHUD()
            
            if let result = authResult {
                
                self?.onLogin?(result.user)
                self?.tracker.track(withName: .login, parameters: nil)
                
            } else if let error = error {
                UIAlertController.show(message: "Wrong email or password")
                print("Error during auth: \(error)")
            }
        }
    }
}
