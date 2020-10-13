//
//  Trackable.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation

enum AnalyticsEvent: String {
    case login = "signin"
    case join
    case changeUserData = "change_user_data"
}

protocol Trackable {
    func track(withName name: AnalyticsEvent, parameters: [String: Any]?)
}
