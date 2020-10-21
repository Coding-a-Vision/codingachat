//
//  EditPasswordCoordinator.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 21/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class EditPasswordCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let presenter: UIViewController
    let editPasswordViewController: UIViewController
    
    init(presenter: UIViewController) {
        self.presenter = presenter
        self.editPasswordViewController = EditPasswordViewController()
    }
    
    func start() {
        presenter.navigationController?.pushViewController(editPasswordViewController, animated: true)
    }
}
