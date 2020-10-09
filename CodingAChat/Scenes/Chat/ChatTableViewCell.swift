//
//  ChatTableViewCell.swift
//  CodingAChat
//
//  Created by Riccardo Rizzo on 09/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import Firebase

extension DateFormatter {
    
    static var ui: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm"
        return formatter
    }
}

extension Date {
    var asString: String? {
        return DateFormatter.ui.string(from: self)
    }
}


class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    func configure(with message: Message) {
        authorLabel.text = message.author.displayName
        messageLabel.text = message.message
        dateLabel.text = message.date.asString
    }
    
}
