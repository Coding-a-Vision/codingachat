//
//  ChannelCardCollectionViewCell.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 09/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

class ChannelCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    
    func configure(withChannel channel: Channel) {
        self.channelName.text = channel.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
