//
//  EditDetailsCoordinator.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import FirebaseAuth
import PromiseKit
import SVProgressHUD

class EditDetailsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let viewController: EditDetailsViewController
    private let presenter: UIViewController
    private let navigator: UINavigationController
    private let user: User
    private let tracker: Trackable
    
    init(presenter: UIViewController, user: User, tracker: Trackable) {
        self.presenter = presenter
        self.user = user
        self.tracker = tracker
        self.viewController = EditDetailsViewController(user: user)
        self.navigator = WhiteNavigationController(rootViewController: viewController)
    }
    
    func start() {
        viewController.delegate = self
        presenter.present(navigator, animated: true, completion: nil)
    }
}

extension EditDetailsCoordinator: EditDetailsViewControllerDelegate {
    
    func userDidSaveInfo(withDisplayName displayName: String, andImage image: UIImage) {
        
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        
        UIViewController.showHUD(message: "Wait...")
        
        let storage = FirebaseStorageServices()
        
        firstly {
            storage.uploadImage(data, imageName: "\(user.uid).jpg")
        }.then { url in
            self.updateUserData(displayName: displayName, url: url)
        }.done {
            self.tracker.track(withName: .changeUserData, parameters: nil)
            self.presenter.dismiss(animated: true, completion: nil)
        }.ensure {
            UIViewController.dismissHUD()
        }.catch { error in
            UIAlertController.show(message: "Error while saving data")
            print(error)
        }
    }
    
    func updateUserData(displayName: String, url: URL) -> Promise<Void> {
        
        return Promise<Void> { seal in
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = displayName
            changeRequest?.photoURL = url
            
            changeRequest?.commitChanges { (error) in
                
                if let error = error {
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    func goToEditPassword() {
        let editPasswordCoordinator = EditPasswordCoordinator(presenter: viewController)
        editPasswordCoordinator.start()
        childCoordinators.append(editPasswordCoordinator)
    }
    
}
