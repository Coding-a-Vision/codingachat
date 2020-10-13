//
//  AnalyticsTracker.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation
import FirebaseAnalytics

class AnalyticsTracker: Trackable {
    func track(withName name: AnalyticsEvent, parameters: [String: Any]?) {
        Analytics.logEvent(name.rawValue, parameters: parameters)
    }
}
