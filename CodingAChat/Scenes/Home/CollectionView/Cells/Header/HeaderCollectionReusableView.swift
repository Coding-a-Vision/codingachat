//
//  HeaderCollectionReusableView.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 09/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    var editProfileSettings: (() -> Void)?
    var settingsView : (() -> Void)?

    @IBAction func editProfileSettings(_ sender: Any) {
        editProfileSettings?()
    }
    
    @IBAction func openSettings() {
        settingsView?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
