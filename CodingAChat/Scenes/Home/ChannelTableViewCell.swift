//
//  ChannelTableViewCell.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    func configure(with channel: Channel) {
        textLabel?.text = channel.name
    }
    
}
