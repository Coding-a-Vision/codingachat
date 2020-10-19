//
//  ColorsViewController.swift
//  CodingAChat
//
//  Created by Alex on 16/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

protocol ColorsViewActionDelegate: class {
    func changeBg(withSelected selected: Int, withIndexPath indexPath: IndexPath)
}

class BackgroundsViewController: UIViewController {
    
    weak var delegate: ColorsViewActionDelegate?
    let selected: Int
    @IBOutlet weak var collectionView: UICollectionView!

    init(selected: Int) {
        self.selected = selected
        super.init(nibName: nil, bundle: nil)

    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: Constants.bgNibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Constants.bgReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension BackgroundsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if selected == 1 {
            return Sfondi.allCases.count
        } else {
            return ColorBg.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.bgReuseIdentifier, for: indexPath) as? CollectionViewCell else {
            
            fatalError("Wrong cell type")
        }
        if selected == 1 {
            cell.configure(bground: Sfondi.allCases[indexPath.item].rawValue)
            return cell
        } else {
            cell.configure(color: ColorBg.allCases[indexPath.item].rawValue)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.changeBg(withSelected: self.selected, withIndexPath: indexPath)
    }
}
