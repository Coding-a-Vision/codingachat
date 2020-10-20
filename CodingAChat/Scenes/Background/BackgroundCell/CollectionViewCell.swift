//
//  CollectionViewCell.swift
//  CodingAChat
//
//  Created by Alex on 16/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imagebg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(color: ColorBg) {
        self.name.text = color.rawValue.uppercased()
        self.imagebg.backgroundColor = color.color
        self.name.textColor = color == .black ? .white : .black
        buildUI()
    }

    func configure(bground: Background) {
        self.name.text = bground.rawValue.uppercased()
        self.imagebg.image = UIImage(named: bground.assetName)
        self.imagebg.contentMode = .scaleToFill
        buildUI()
    }
    
    func buildUI() {

        layer.cornerRadius = 10
        layer.borderWidth = 0.63
    }
}
