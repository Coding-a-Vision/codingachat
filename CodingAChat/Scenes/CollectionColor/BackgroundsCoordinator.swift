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
    private let number: Int
    
    init(presenter: UIViewController, number: Int) {
        self.presenter = presenter
        self.number = number
        self.viewController = BackgroundsViewController(selected: number)
        self.navigator = WhiteNavigationController(rootViewController: viewController)
    }
    
    func start() {
        viewController.delegate = self
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BackgroundsCoordinator: ColorsViewActionDelegate {
    func changeBg(withSelected selected: Int, withIndexPath indexPath: IndexPath) {
        print("Hai tappato la cella numero \([indexPath.item+1]) che è \(ColorBg.allCases[indexPath.item].rawValue)")
        let alertController = UIAlertController(title: NSLocalizedString("Vuoi cambiare sfondo?", comment: ""), message: "", preferredStyle: .actionSheet)

        let yes = UIAlertAction(title: NSLocalizedString("Cambia sfondo", comment: ""), style: .default) { [weak self] _ in
            UserDefaults.standard.removeObject(forKey: "BACKGROUND_IMAGE")
            if selected == 1 {
                UserDefaults.standard.set(Sfondi.allCases[indexPath.item].rawValue, forKey: "BACKGROUND_IMAGE")
                print("Hai cambiato sfondo con il colore \(Sfondi.allCases[indexPath.item].rawValue)")
            } else {
                UserDefaults.standard.set(ColorBg.allCases[indexPath.item].rawValue, forKey: "BACKGROUND_IMAGE")
                print("Hai cambiato sfondo con il colore \(ColorBg.allCases[indexPath.item].rawValue)")
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changedColor"), object: nil)
            self?.presenter.navigationController?.popViewController(animated: true)
        }
        
        let not = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
            
            print("Non hai cambiato")
        }
        alertController.addAction(yes)
        alertController.addAction(not)
        presenter.present(alertController, animated: true, completion: nil)
    }
    
}
