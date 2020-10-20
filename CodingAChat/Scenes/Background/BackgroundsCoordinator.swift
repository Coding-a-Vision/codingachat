//
//  ColorsCoordinator.swift
//  CodingAChat
//
//  Created by Alex on 19/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class BackgroundsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigator: UINavigationController
    let viewController: BackgroundsViewController
    private let presenter: UIViewController
    private let number: BackgroundType
    
    init(presenter: UIViewController, number: BackgroundType) {
        self.presenter = presenter
        self.number = number
        self.viewController = BackgroundsViewController(selected: number)
        self.navigator = UINavigationController(rootViewController: viewController)
    }
    
    func start() {
        viewController.delegate = self
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BackgroundsCoordinator: ColorsViewActionDelegate {

    func changeBg(withSelected selected: BackgroundType, withIndexPath indexPath: IndexPath) {

        let alertController = UIAlertController(title: NSLocalizedString("background_messages.alertSelect.tile", comment: ""), message: "", preferredStyle: .actionSheet)

        let yes = UIAlertAction(title: NSLocalizedString("genercis.yes", comment: ""), style: .default) { [weak self] _ in
            UserDefaults.standard.removeObject(forKey: Constants.userDefaultBackgroundImage)
            if selected == .image {
                UserDefaults.standard.set(Background.allCases[indexPath.item].rawValue, forKey: Constants.userDefaultBackgroundImage)
            } else {
                UserDefaults.standard.set(ColorBg.allCases[indexPath.item].rawValue, forKey: Constants.userDefaultBackgroundImage)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.userDefaultChangedColor), object: nil)
            self?.presenter.navigationController?.popViewController(animated: true)
        }
        
        let not = UIAlertAction(title: NSLocalizedString("generics.cancel", comment: ""), style: .cancel) { _ in
        }
        alertController.addAction(yes)
        alertController.addAction(not)
        presenter.present(alertController, animated: true, completion: nil)
    }
    
}
