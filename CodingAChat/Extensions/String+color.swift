//
//  String+color.swift
//  CodingAChat
//
//  Created by Alex on 17/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

extension String {
    func findColor(withName name: String) -> UIColor? {
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
        default: return nil
        }
    }
}
