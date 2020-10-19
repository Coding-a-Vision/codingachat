//
//  SettingsViewController.swift
//  CodingAChat
//
//  Created by Marco Caliò on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

protocol settingsActionDelegate: class {
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
        self.title = "Settings"
        loadBackgroundImage()
        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "changedColor"), object: nil, queue: nil) { [weak self] _ in
            self?.loadBackgroundImage()
        }
        versionLabel.text = versionString
    }
    
    func loadBackgroundImage() {
        if let imageData = UserDefaults.standard.object(forKey: TAG) as? String, let color = imageData.findColor(withName: imageData) {
            print("Sfondo tinta unica colore \(imageData)")
            print("Ho convertito il colore ed è \(color)")
            backgroundImage.backgroundColor = color
            backgroundImage.image = .none
            } else {
            if let imageData = UserDefaults.standard.object(forKey: TAG) as? String, let image = UIImage(named: imageData) {
                print("Sfondo chiamato \(imageData)")
                backgroundImage.backgroundColor = .none
                backgroundImage.image = image
            } else {
                backgroundImage = UIImageView(image: UIImage(named: "placeholder"))
            }
        }
    }
    var versionString: String? {
        
        guard
            let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        else { return nil }
        
        return "ver \(appVersionString) (\(buildNumber))"
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        delegate?.logout()
    }
    
    @IBAction func contactUsButton(_ sender: Any) {
        delegate?.contactUs()
    }
    
    @IBAction func changeBackgroundImage(_ sender: Any) {
        
        let alertController = UIAlertController(title: NSLocalizedString("Vuoi cambiare sfondo?", comment: ""), message: "", preferredStyle: .actionSheet)

        let goToBackgrounds = UIAlertAction(title: NSLocalizedString("Sfondi", comment: ""), style: .default) { _ in
            
            self.navigationController?.pushViewController(ColorsViewController(selected: 1), animated: true)
        }

        let goToColors = UIAlertAction(title: NSLocalizedString("Colori a tinta unica", comment: ""), style: .default) { _ in
            
            self.navigationController?.pushViewController(ColorsViewController(selected: 2), animated: true)
        }

        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(goToBackgrounds)
        alertController.addAction(goToColors)
        alertController.addAction(cancel)
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

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        backgroundImage.image = image
        let imagepng = image.pngData()
        userDefault.set(imagepng, forKey: TAG)
        dismiss(animated: true, completion: nil)
    }
    
}
