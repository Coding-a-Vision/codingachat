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
class SettingsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let viewController: SettingsViewController
    private let presenter: UIViewController
    private let tracker: Trackable
    
    init(presenter: UIViewController, tracker: Trackable) {
        self.presenter = presenter
        self.tracker = tracker
        viewController = SettingsViewController()
    }
    
    func start() {
        viewController.delegate = self
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SettingsCoordinator: settingsActionDelegate {
    
    func contactUs() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
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
        self.logout(tracker: tracker)
    }

    func goToBg() {
        let alertController = UIAlertController(title: NSLocalizedString("settings_messages.alertSelect.title", comment: ""), message: "", preferredStyle: .actionSheet)

        let goToBackgrounds = UIAlertAction(title: NSLocalizedString("settings_messages.alertSelect.changeBg", comment: ""), style: .default) { _ in
            let backgroundsCoordinator = BackgroundsCoordinator(presenter: self.viewController, number: .image)
            backgroundsCoordinator.start()
            self.childCoordinators.append(backgroundsCoordinator)
        }

        let goToColors = UIAlertAction(title: NSLocalizedString("settings_messages.alertSelect.changeColor", comment: ""), style: .default) {_ in
            let backgroundsCoordinator = BackgroundsCoordinator(presenter: self.viewController, number: .color)
            backgroundsCoordinator.start()
            self.childCoordinators.append(backgroundsCoordinator)
        }

        let cancel = UIAlertAction(title: NSLocalizedString("generics.cancel", comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(goToBackgrounds)
        alertController.addAction(goToColors)
        alertController.addAction(cancel)
        presenter.present(alertController, animated: true, completion: nil)
    }
}

