//
//  FakeTracker.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation

class FakeTracker: Trackable {
    func track(withName name: AnalyticsEvent, parameters: [String: Any]?) {
        print("Track event: \(name.rawValue)")
        
        parameters?.forEach{ p in
            print("Param: \(p.key) = \(p.value)")
        }
    }
}
