//
//  HomeViewController+CollectionView.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 09/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderViewID", for: indexPath) as? HeaderCollectionReusableView else { fatalError() }
        header.editProfileSettings = { [weak self] in
            self!.delegate?.onEditDetailsAction()
        }
        header.settingsView = { [weak self] in
            self?.delegate?.onSettings()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: 62)
    }
    
    // MARK: - Channel cards
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelCardID", for: indexPath) as? ChannelCardCollectionViewCell else { fatalError() }
        cell.configure(withChannel: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 40 , height: 63)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.channelJoin(selectedChannel: items[indexPath.row])
    }
}
