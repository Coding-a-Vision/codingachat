//
//  UIAlertController+show.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 12/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func show(title: String? = nil, message: String) {
        guard let controller = UIApplication.topViewController() else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        controller.present(alert, animated: true, completion: nil)
    }
}
