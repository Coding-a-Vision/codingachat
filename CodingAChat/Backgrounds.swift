//
//  Backgrounds.swift
//  CodingAChat
//
//  Created by Alex on 17/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

enum ColorBg: String, CaseIterable {
    case none
    case black
    case darkGray
    case lightGray
    case white
    case gray
    case red
    case green
    case blue
    case cyan
    case yellow
    case magenta
    case orange
    case purple
    case brown
    
    var color: UIColor {
        
        switch self {
        case .none:
            return UIColor.systemBackground
        case .blue:
            return UIColor.blue
        case .black:
            return .black
        case .darkGray:
            return .darkGray
        case .white:
            return .white
        case .gray:
            return .gray
        case .red:
            return UIColor.red.withAlphaComponent(0.8)
        case .green:
            return .green
        case .cyan:
            return .cyan
        case .yellow:
            return .yellow
        case .magenta:
            return .magenta
        case .orange:
            return .orange
        case .purple:
            return .purple
        case .brown:
            return .brown
        case .lightGray:
            return .lightGray
        }
    }
}

enum Background: String, CaseIterable {
    case type1, type2
    
    var assetName: String {
        switch self {
        case .type1:
            return "sfondo1"
        case .type2:
            return "sfondo2"
        }
    }
}

