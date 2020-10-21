//
//  HomeViewController.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func onEditDetailsAction()
    func onSettings()
    func fetchData()
    func channelJoin(selectedChannel: Channel)
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [Channel] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title
        self.title = NSLocalizedString("home_messages.tile", comment: "")
        
        let headerViewNib = UINib(nibName: Constants.homeHeaderViewNib, bundle: nil)
        collectionView.register(headerViewNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.homeHeaderIdentifier)
        
        let channelCardNib = UINib(nibName: Constants.homeChannelViewNib, bundle: nil)
        collectionView.register(channelCardNib, forCellWithReuseIdentifier: Constants.homeChannelIdentifier)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Create a new channel", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Channel's name"
        }
        
        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
            print("yes, it is \(String(describing: alertController.textFields))")
        }
        
        let not = UIAlertAction(title: "No", style: .default) { _ in
            print("not")
        }
        
        alertController.addAction(yes)
        alertController.addAction(not)
        present(alertController, animated: true, completion: nil)
    }


override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    delegate?.fetchData()
}
}
