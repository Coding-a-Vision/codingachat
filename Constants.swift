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

// MARK: -- UserDefaults
    static var userDefaultBackgroundImage: String = "BACKGROUND_IMAGE"
    static var userDefaultChangedColor: String = "changedColor"

// MARK: -- HOME
    static var homeHeaderViewNib: String = "HeaderCollectionReusableView"
    static var homeHeaderIdentifier: String = "HeaderViewID"
    static var homeChannelViewNib: String = "ChannelCardCollectionViewCell"
    static var homeChannelIdentifier: String = "ChannelCardID"

// MARK: -- BackgroundViewController
    static var bgNibName: String = "CollectionViewCell"
    static var bgReuseIdentifier: String = "Cell"
}
