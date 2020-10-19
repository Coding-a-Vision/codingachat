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
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var notRegisterLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    @IBAction func standardLogin() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            UIAlertController.show(message: NSLocalizedString("login_messages.error.completeFields", comment: ""))
            return
        }
        delegate?.onLogin(withEmail: email, andPassword: password)
    }
    
    private func buildUI() {
        self.emailTextField.placeholder = NSLocalizedString("login_messages.email.textfield.placeholder", comment: "")
        self.passwordTextField.placeholder = NSLocalizedString("login_messages.password.textfield.placeholder", comment: "")
        self.button.setTitle(NSLocalizedString("login_messages.button.login.title", comment: ""), for: .normal)
        self.notRegisterLabel.text = NSLocalizedString("login_messages.notregistered.label.title", comment: "")
        self.signUpButton.setTitle(NSLocalizedString("login_messages.button.signup.title", comment: ""), for: .normal)
    }
}
