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
    case photo
}

struct Author: SenderType {
    var senderId: String
    var displayName: String
}

struct ImageMediaItem: MediaItem {
   
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
}

struct Message {
    
    let id: String
    let author: Author
    let message: String?
    let date: Date
    let type: Type
    let userPictureUrl: String?
    var photo: ImageMediaItem?
    
    init?(json: [String: Any], id: String, date: Date) {
        guard
            let author = json["author"] as? String,
            let authorId = json["authorId"] as? String,
            let kindString = json["kind"] as? String,
            let type = Type(rawValue: kindString)
        else { return nil }
        
        self.author = Author(senderId: authorId, displayName: author)
        self.message = json["message"] as? String
        self.id = id
        self.date = date
        self.type = type
        self.userPictureUrl = json["userPictureUrl"] as? String
        
        if let urlString = json["pictureUrl"] as? String, let url = URL(string: urlString) {
            photo = ImageMediaItem(url: url, image: nil, placeholderImage: UIImage(), size: CGSize(width: 240, height: 240))
        }

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
            return MessageKind.text(message ?? "")
        case .photo:
            return MessageKind.photo(photo!)
        }
    }
}
