//
//  EditDetailsCoordinator.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import PromiseKit
import SVProgressHUD

class EditDetailsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let viewController: EditDetailsViewController
    private let presenter: UIViewController
    private let user: User
    
    init(presenter: UIViewController, user: User) {
        self.presenter = presenter
        self.user = user
        viewController = EditDetailsViewController(user: user)
    }
    
    func start() {
        viewController.delegate = self
        presenter.present(viewController, animated: true, completion: nil)
    }
}

extension EditDetailsCoordinator: EditDetailsViewControllerDelegate {
    
    func userDidSaveInfo(withDisplayName displayName: String, andImage image: UIImage) {
        
        SVProgressHUD.show(withStatus: "Wait...")
        
        firstly {
            uploadImage(image)
        }.then { url in
            self.updateUserData(displayName: displayName, url: url)
        }.done {
            self.presenter.dismiss(animated: true, completion: nil)
        }.ensure {
            SVProgressHUD.dismiss()
        }.catch { error in
            UIAlertController.show(message: "Error while saving data", from: self.viewController)
            print(error)
        }
    }
    
    func uploadImage(_ image: UIImage) -> Promise<URL> {
        
        return Promise<URL> { seal in
            
            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let imageRef = storageRef.child("\(user.uid).jpg")
            
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                
                if let metadata = metadata {
                    print("ok!!! \(metadata)")
                } else if let error = error {
                    seal.reject(error)
                }
                
                // You can also access to download URL after upload.
                imageRef.downloadURL { (url, error) in
                    
                    if let url = url {
                        seal.fulfill(url)
                    } else if let error = error {
                        seal.reject(error)
                    }
                }
            }
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
}
