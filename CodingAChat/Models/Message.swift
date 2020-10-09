//
//  Message.swift
//  CodingAChat
//
//  Created by Riccardo Rizzo on 06/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
import MessageKit

enum Type: String {
    case text
}

struct Author: SenderType, Hashable {
    var senderId: String
    var displayName: String
}

struct Message: Hashable {
    
    let id: String
    let author: Author
    let message: String
    let date: Date
    let type: Type
    
    init?(json: [String: Any], id: String, date: Date) {
        guard
            let author = json["author"] as? String,
            let message = json["message"] as? String,
            let authorId = json["authorId"] as? String,
            let kindString = json["kind"] as? String,
            let type = Type(rawValue: kindString)
        else { return nil }
        
        self.author = Author(senderId: authorId, displayName: author)
        self.message = message
        self.id = id
        self.date = date
        self.type = type
    }
}

extension Message: MessageType {
   
    var sender: SenderType {
        return author
    }
    
    var messageId: String {
        return id
    }
    
    var sentDate: Date {
        return date
    }
    
    var kind: MessageKind {
        switch type {
        case .text:
            return MessageKind.text(message)
        }
    }
}
