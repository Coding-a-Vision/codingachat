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
    
    init(presenter: UIViewController) {
        self.presenter = presenter
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
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        delegate.coordinator?.start()
    }

    func goToBg() {
        let alertController = UIAlertController(title: NSLocalizedString("Vuoi cambiare sfondo?", comment: ""), message: "", preferredStyle: .actionSheet)

        let goToBackgrounds = UIAlertAction(title: NSLocalizedString("Sfondi", comment: ""), style: .default) { _ in
            let backgroundsCoordinator = BackgroundsCoordinator(presenter: self.viewController, number: 1)
            backgroundsCoordinator.start()
            self.childCoordinators.append(backgroundsCoordinator)
        }

        let goToColors = UIAlertAction(title: NSLocalizedString("Colori a tinta unica", comment: ""), style: .default) { _ in
            let backgroundsCoordinator = BackgroundsCoordinator(presenter: self.viewController, number: 2)
            backgroundsCoordinator.start()
            self.childCoordinators.append(backgroundsCoordinator)
        }

        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(goToBackgrounds)
        alertController.addAction(goToColors)
        alertController.addAction(cancel)
        presenter.present(alertController, animated: true, completion: nil)
    }
}

