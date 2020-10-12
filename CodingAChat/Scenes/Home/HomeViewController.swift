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
    func fetchData()
    func channelJoin(selectedChannel : Channel)
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    TO DO: Watch it and if is useless delete it
//    @IBOutlet weak var tableView: UITableView! {
//        didSet {
//            let nib = UINib(nibName: "ChannelTableViewCell", bundle: nil)
//            tableView.register(nib, forCellReuseIdentifier: "cellID")
//        }
//    }
    
    var items: [Channel] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title
        self.title = "Home"
        
        // Styling (hiding) navigation bar
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.clear]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        let headerViewNib = UINib(nibName: "HeaderCollectionReusableView", bundle: nil)
        collectionView.register(headerViewNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderViewID")
        
        let channelCardNib = UINib(nibName: "ChannelCardCollectionViewCell", bundle: nil)
        collectionView.register(channelCardNib, forCellWithReuseIdentifier: "ChannelCardID")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.fetchData()
    }
}
