//
//  SettingsCoordinator.swift
//  CodingAChat
//
//  Created by Marco Caliò on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
class SettingsCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    private let viewController : SettingsViewController
    private let window : UIWindow
    private let presenter : UIViewController
    
    init(window : UIWindow, presenter : UIViewController) {
        self.window=window
        self.presenter=presenter
        viewController = SettingsViewController()
    }
    
    func start() {
        viewController.delegate=self
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SettingsCoordinator : settingsActionDelegate {

    func contactUs() {
      if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
        mail.setToRecipients(["info@codingavision.it"])
        presenter.present(mail, animated: true, completion: nil)
      } else {
        print("Error")
      }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        delegate.coordinator?.start()
    }
}

