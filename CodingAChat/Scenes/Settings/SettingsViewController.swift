//
//  SettingsViewController.swift
//  CodingAChat
//
//  Created by Marco Caliò on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

protocol settingsActionDelegate : class {
    func contactUs()
    func logout()
}

class SettingsViewController: UIViewController {
    
    weak var delegate: settingsActionDelegate?
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    var userDefault = UserDefaults.standard
     let TAG = "BACKGROUND_IMAGE"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackgroundImage()
        version()
    }
    
    func loadBackgroundImage() {
        if let imageData = UserDefaults.standard.object(forKey: TAG) as? Data,
            let image = UIImage(data: imageData) {
            backgroundImage.image=image
        }
    }
    
    func version(){
        let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        versionLabel.text = " ver \(appVersionString) (\(buildNumber))"
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        delegate?.logout()
    }
    
    @IBAction func contactUsButton(_ sender: Any) {
        delegate?.contactUs()
    }
    
    @IBAction func changeBackgroundImage(_ sender: Any) {
        
     let alertController = UIAlertController(title: NSLocalizedString("generics_messages.alertSelect.title", comment: ""), message: "", preferredStyle: .actionSheet)
         
         let cameraAction = UIAlertAction(title: NSLocalizedString("generics_messages.alertSelect.camera", comment: ""), style: .default) { _ in
             
             self.showPicker(with: .camera)
         }
         
         let gallery = UIAlertAction(title: NSLocalizedString("generics_messages.alertSelect.gallery", comment: ""), style: .default) { _ in
             
             self.showPicker(with: .photoLibrary)
         }
         
         let saved = UIAlertAction(title: NSLocalizedString("generics_messages.alertSelect.savedInAlbum", comment: ""), style: .default) { _ in
             
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
    
}

extension SettingsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        backgroundImage.image = image
        let imagepng = image.pngData()
        userDefault.set(imagepng, forKey: TAG)
        dismiss(animated: true, completion: nil)
    }
    
}
