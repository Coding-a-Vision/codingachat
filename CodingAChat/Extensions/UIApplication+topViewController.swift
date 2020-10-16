//
//  UIApplication+topViewController.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 12/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController? = nil) -> UIViewController? {
       
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return nil }
        
        let acontroller = controller ?? window.rootViewController
        
        if let navigationController = acontroller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = acontroller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
      
        if let presented = acontroller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
