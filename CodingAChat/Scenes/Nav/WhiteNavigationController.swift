//
//  WhiteNavigationController.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class WhiteNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor.systemBackground
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationBar.shadowImage = UIImage()
    }
}
