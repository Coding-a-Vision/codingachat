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
    var onLogin: ((User) -> Void)?
    
    
    init(window: UIWindow) {
        self.window = window
        self.loginViewController = LoginViewController()
    }
    
    func start() {
        loginViewController.delegate = self
        window.rootViewController = loginViewController
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    
    func onLogin(withEmail email: String, andPassword password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let result = authResult {
                
                self?.onLogin?(result.user)
                
            } else if let error = error {
                UIAlertController.show("Wrong email or password", from: self!.loginViewController)
                print("Error during auth: \(error)")
            }
        }
    }
}
