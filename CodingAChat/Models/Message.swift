//
//  Message.swift
//  CodingAChat
//
//  Created by Riccardo Rizzo on 06/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Hashable {
    @DocumentID var id: String? = UUID().uuidString
    let author: String
    let message: String
    
    init?(json: [String: Any]) {
      guard
        let author = json["author"] as? String,
        let message = json["message"] as? String
      else { return nil }
      self.author = author
      self.message = message
    }
    
}
