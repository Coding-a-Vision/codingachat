//
//  Constants.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 16/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation

struct Constants {
    
    static func getNotificationChannelID(from channelName: String) -> String {
        return "notifications_\(channelName)"
    }
}
