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
        self.title = NSLocalizedString("generics_messages.home.tile", comment: "")
        
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
