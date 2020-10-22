//
//  Coordinator + Logout.swift
//  CodingAChat
//
//  Created by Marco Caliò on 22/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation
import FirebaseAuth
extension Coordinator {
    func logout (tracker : Trackable) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            tracker.track(withName: .logout, parameters: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        delegate.coordinator?.start()
    }
}

