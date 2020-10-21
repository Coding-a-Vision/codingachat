//
//  EditPasswordCoordinator.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 21/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import FirebaseAuth

class EditPasswordCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let presenter: UIViewController
    let editPasswordViewController: EditPasswordViewController
    
    private let user: User
    
    init(presenter: UIViewController, user: User) {
        self.presenter = presenter
        self.editPasswordViewController = EditPasswordViewController()
        self.user = user
    }
    
    func start() {
        editPasswordViewController.delegate = self
        presenter.navigationController?.pushViewController(editPasswordViewController, animated: true)
    }
}

extension EditPasswordCoordinator: EditPasswordViewControllerDelegate {
    func changePassword(password: String) {
        user.updatePassword(to: password) { [weak self] (error) in
            if let _ = error {
                let alert = UIAlertController(title: "Error", message: "Do login again to change password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.editPasswordViewController.present(alert, animated: true, completion: nil)
            } else {
                // Success: go back
                self?.presenter.navigationController?.popViewController(animated: true)
            }
        }
    }
}
