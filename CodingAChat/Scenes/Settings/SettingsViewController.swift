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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func logoutButton(_ sender: Any) {
        delegate?.logout()
    }
    
    @IBAction func contactUsButton(_ sender: Any) {
        delegate?.contactUs()
    }
}
