//
//  AppDelegate.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 25/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let myWindow = UIWindow(frame: UIScreen.main.bounds)
        
        coordinator = AppCoordinator(window: myWindow)
        coordinator?.start()
        self.window = myWindow
        
        window?.makeKeyAndVisible()
        return true
    }
    
}

