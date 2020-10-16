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
        
        // Register for push
        registerForPushNotifications()
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func registerForPushNotifications() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if granted {
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
}

