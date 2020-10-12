//
//  LoginViewController.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func onLogin(withEmail email: String, andPassword password: String)
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func standardLogin() {
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            UIAlertController.show(message: "Please, fill in all fields")
            return
        }
        
        delegate?.onLogin(withEmail: email, andPassword: password)
    }
}
