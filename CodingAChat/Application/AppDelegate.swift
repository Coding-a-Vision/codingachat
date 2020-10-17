//
//  AppDelegate.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 25/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    var gcmMessageIDKey = "gcmMessageIDKey"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let myWindow = UIWindow(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared().isEnabled = true
        
        coordinator = AppCoordinator(window: myWindow)
        coordinator?.start()
        self.window = myWindow
        
        // Register for push
        registerForFCMNotifications()
        Messaging.messaging().delegate = self
        
        window?.makeKeyAndVisible()
        return true
    }

    func registerForFCMNotifications() {
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Token: \(fcmToken)")
    }
    
    /*
     
     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
     
         let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
         let token = tokenParts.joined()
         print("Device Token: \(token)")
         }
         
         func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
         print("Failed to register: \(error)")
     } */
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Print full message.
        print(userInfo)
        
        if UIApplication.shared.applicationState == .active {
            // Mostro semplicemente un alert all'utente, magari non bloccante
        } else {
            guard let channelId = userInfo["channelId"] as? String, let channelName = userInfo["channelName"] as? String else { return }
           
            let channel = Channel(id: channelId, name: channelName)
            
            coordinator?.goToChannel(channel)
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
