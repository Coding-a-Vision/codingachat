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
    func addChannel(channel: String)
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    var alertController: UIAlertController?
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        
        guard let lenght = alertController?.textFields?.first?.text?.count else { return }
        
        if lenght > 0 {
            alertController?.actions.last?.isEnabled = true
        } else {
            alertController?.actions.last?.isEnabled = false
        }
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        
        alertController = UIAlertController(title: "Create a new channel", message: "", preferredStyle: .alert)
        
        guard let alertController = alertController else { return }
                
        alertController.addTextField(configurationHandler: { (textField) -> Void in
                    textField.placeholder = "Enter Channel's name"
                    textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
                })
        
        let create = UIAlertAction(title: "Create", style: .default) { [weak self] _ in
            if let channelName = alertController.textFields?.first?.text, !channelName.isEmpty {
                self?.delegate?.addChannel(channel: channelName)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            print("not")
        }
        
        alertController.addAction(cancel)
        alertController.addAction(create)
        alertController.actions.last?.isEnabled = false
        present(alertController, animated: true, completion: nil)
    }

override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    delegate?.fetchData()
}
}
