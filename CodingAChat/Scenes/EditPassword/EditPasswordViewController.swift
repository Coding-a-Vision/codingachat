//
//  EditPasswordViewController.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 21/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

protocol EditPasswordViewControllerDelegate: class {
    func changePassword(password: String)
}

class EditPasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    
    weak var delegate: EditPasswordViewControllerDelegate?
    
    @IBAction func saveNewPassword(_ sender: Any) {
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty, let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            // TO DO: Use extension for alerts
            let alert = UIAlertController(title: "Error", message: "login_messages.error.completeFields".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard newPassword == confirmPassword else {
            // TO DO: Use extension for alerts
            let alert = UIAlertController(title: "Error", message: "edit_password.error.notMatchingPasswords".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        delegate?.changePassword(password: newPassword)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
