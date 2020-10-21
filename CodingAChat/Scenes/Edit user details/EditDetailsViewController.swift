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
    func goToEditPassword()
}

class EditDetailsViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var userPictureImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
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
        buildUI()
        self.displayNameTextField.text = user.displayName
        userPictureImageView.kf.setImage(with: user.photoURL)
        self.emailLabel.text = user.email
    }
    
    @IBAction func pickImage() {
        
        let alertController = UIAlertController(title: NSLocalizedString("edit_messages.alertSelect.title", comment: ""), message: "", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: NSLocalizedString("edit_messages.alertSelect.camera", comment: ""), style: .default) { _ in
            
            self.showPicker(with: .camera)
        }
        
        let gallery = UIAlertAction(title: NSLocalizedString("edit_messages.alertSelect.gallery", comment: ""), style: .default) { _ in
            
            self.showPicker(with: .photoLibrary)
        }
        
        let saved = UIAlertAction(title: NSLocalizedString("edit_messages.alertSelect.savedInAlbum", comment: ""), style: .default) { _ in
            
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
            UIAlertController.show(message: NSLocalizedString("edit_messages.error.completeFields", comment: ""))
            return
        }
        
        delegate?.userDidSaveInfo(withDisplayName: displayName, andImage: image)
    }
    
    
    @IBAction func changePasswordAction(_ sender: Any) {
        delegate?.goToEditPassword()
    }
    
    private func buildUI() {
        self.saveButton.setTitle(NSLocalizedString("edit_messages.saveButton.title", comment: ""), for: .normal)
        self.displayNameLabel.text = NSLocalizedString("edit_messages.displayNameTextField.text", comment: "")
    }
}

extension EditDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        userPictureImageView.image = image
        dismiss(animated: true, completion: nil)
    }
}
