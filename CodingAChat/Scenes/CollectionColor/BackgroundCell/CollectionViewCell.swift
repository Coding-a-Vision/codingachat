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

    func configure(color : String) {

        self.name.text = color.uppercased()
        if self.name.text == "BLACK" { self.name.textColor = UIColor.white } else { self.name.textColor = UIColor.black }
        self.imagebg.backgroundColor = color.findColor(withName: color)
        buildUI()
    }

    func configure(bground : String) {

        self.name.text = bground.uppercased()
        self.imagebg.image = UIImage(named: bground)
        self.imagebg.contentMode = .scaleToFill
        buildUI()
    }
    
    func buildUI() {

        layer.cornerRadius = 10
        layer.borderWidth = 0.63
    }
}