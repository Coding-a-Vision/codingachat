//
//  ColorsViewController.swift
//  CodingAChat
//
//  Created by Alex on 16/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

enum BackgroundType {
    case image
    case color
}

protocol ColorsViewActionDelegate: class {
    func changeBg(withSelected selected: BackgroundType, withIndexPath indexPath: IndexPath)
}

class BackgroundsViewController: UIViewController {
    
    weak var delegate: ColorsViewActionDelegate?
    let selected: BackgroundType
    @IBOutlet weak var collectionView: UICollectionView!

    init(selected: BackgroundType) {
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
        if selected == .image {
            return Background.allCases.count
        } else {
            return ColorBg.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.bgReuseIdentifier, for: indexPath) as? CollectionViewCell else {
            
            fatalError("Wrong cell type")
        }
        if selected == .image {
            cell.configure(bground: Background.allCases[indexPath.item])
            return cell
        } else {
            cell.configure(color: ColorBg.allCases[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.changeBg(withSelected: self.selected, withIndexPath: indexPath)
    }
}

extension BackgroundsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = view.frame.width-4
        return CGSize(width: side/2, height: side/2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
