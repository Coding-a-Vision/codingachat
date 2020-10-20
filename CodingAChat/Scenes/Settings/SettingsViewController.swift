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
    func goToBg()
}

class SettingsViewController: UIViewController {
    
    weak var delegate: settingsActionDelegate?
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        loadBackgroundImage()
        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Constants.userDefaultChangedColor), object: nil, queue: nil) { [weak self] _ in
            self?.loadBackgroundImage()
        }
        versionLabel.text = versionString
    }
    
    func loadBackgroundImage() {
        backgroundImage.layer.cornerRadius = 10
        backgroundImage.layer.borderWidth = 1
        if let imageData = UserDefaults.standard.object(forKey: Constants.userDefaultBackgroundImage) as? String, let color = ColorBg(rawValue: imageData) {
            backgroundImage.image = .none
            backgroundImage.backgroundColor = color.color
            if color == .none || color == .white {
                backgroundImage.layer.borderColor = UIColor.black.cgColor
            } else { backgroundImage.layer.borderColor = color.color.cgColor }
        } else {
            if let imageData = UserDefaults.standard.object(forKey: Constants.userDefaultBackgroundImage) as? String, let background = Background(rawValue: imageData) {
                backgroundImage.backgroundColor = .none
                backgroundImage.layer.borderColor = UIColor.systemBackground.cgColor
                backgroundImage.image = UIImage(named: background.assetName)
            } else {
                backgroundImage.image = UIImage(named: "placeholder")
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
        delegate?.goToBg()
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
        userDefault.set(imagepng, forKey: Constants.userDefaultBackgroundImage)
        dismiss(animated: true, completion: nil)
    }
    
}
