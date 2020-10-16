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
        
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in
                
            })
        
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Token: \(fcmToken)")
    }
    
    /*
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
            // se utente è loggato recupero il canale dal dizionario e provo a inviare l'utente nel dettaglio della chat
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
