//
//  UIViewController+HUD.swift
//  CodingAChat
//
//  Created by Beppe on 15/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    static func showHUD(message: String){
        
        SVProgressHUD.show(withStatus: message)
    }
    
    static func dismissHUD() {
        
        SVProgressHUD.dismiss()
    }
}
