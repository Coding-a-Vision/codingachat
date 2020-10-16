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

    func configure(name : String) {
        self.name.text = name.uppercased()
        if self.name.text == "BLACK" { self.name.textColor = UIColor.white } else { self.name.textColor = UIColor.black }
        self.imagebg.backgroundColor = findColor(withName: name)
        buildUI()
    }
    
    func buildUI(){
        layer.cornerRadius = 10
        layer.borderWidth = 0.63
    }

    func findColor(withName name: String) -> UIColor {
        switch name {
        case "black": return UIColor.black
        case "darkGray": return UIColor.darkGray
        case "lightGray": return UIColor.lightGray
        case "white": return UIColor.white
        case "gray": return UIColor.gray
        case "red": return UIColor.red
        case "green": return UIColor.green
        case "blue": return UIColor.blue
        case "cyan" : return UIColor.cyan
        case "yellow": return UIColor.yellow
        case "magenta": return UIColor.magenta
        case "orange": return UIColor.orange
        case "purple": return UIColor.purple
        case "brown": return UIColor.brown
        default: return UIColor.systemPink
        }
    }
}
