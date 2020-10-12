//
//  EditDetailsViewController.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

protocol EditDetailsViewControllerDelegate: class {
    func userDidSaveInfo(withDisplayName displayName: String, andImage image: UIImage)
}

class EditDetailsViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var userPictureImageView: UIImageView!
    
    weak var delegate: EditDetailsViewControllerDelegate?
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayNameTextField.text = user.displayName
        userPictureImageView.kf.setImage(with: user.photoURL)
        
        userPictureImageView.layer.borderWidth = 2
        userPictureImageView.layer.borderColor = UIColor.red.cgColor
    }

    @IBAction func pickImage() {
        
        let alertController = UIAlertController(title: "Seleziona la sorgente", message: "", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            
            self.showPicker(with: .camera)
        }
        
        let gallery = UIAlertAction(title: "Gallery", style: .default) { _ in
            
            self.showPicker(with: .photoLibrary)
        }
        
        let saved = UIAlertAction(title: "Saved photo album", style: .default) { _ in
            
            self.showPicker(with: .savedPhotosAlbum)
        }
    
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(gallery)
        alertController.addAction(saved)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showPicker(with source: UIImagePickerController.SourceType) {
        
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func save() {
        
        guard let displayName = displayNameTextField.text, !displayName.isEmpty, let image = userPictureImageView.image else {
            UIAlertController.show(message: "Please, fill in all fields", from: self)
            return
        }
        
        delegate?.userDidSaveInfo(withDisplayName: displayName, andImage: image)
    }
}

extension EditDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        userPictureImageView.image = image
        dismiss(animated: true, completion: nil)
    }
}
