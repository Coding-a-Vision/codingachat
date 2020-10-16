//
//  String+Localization.swift
//  CodingAChat
//
//  Created by Beppe on 16/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}
