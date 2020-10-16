//
//  ColorsViewController.swift
//  CodingAChat
//
//  Created by Alex on 16/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

enum ColorBg: String, CaseIterable {
    case black, darkGray, lightGray, white, gray, red, green, blue, cyan, yellow, magenta, orange, purple, brown
}

private let reuseIdentifier = "Cell"

class ColorsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ColorsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ColorBg.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            
            fatalError("Wrong cell type")
        }
        
        cell.configure(name: ColorBg.allCases[indexPath.item].rawValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hai tappato la cella numero \([indexPath.item+1]) che è il colore \(ColorBg.allCases[indexPath.item].rawValue)")
        let alertController = UIAlertController(title: NSLocalizedString("Vuoi cambiare sfondo?", comment: ""), message: "", preferredStyle: .actionSheet)

        let yes = UIAlertAction(title: NSLocalizedString("Cambia sfondo", comment: ""), style: .default) { _ in
            
            print("Hai cambiato sfondo con il colore \(ColorBg.allCases[indexPath.item].rawValue)")
        }
        
        let not = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
            
            print("Non hai cambiato")
        }
        alertController.addAction(yes)
        alertController.addAction(not)
        present(alertController, animated: true, completion: nil)
    }
}

extension ColorsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

