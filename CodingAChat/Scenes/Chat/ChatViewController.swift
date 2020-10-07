//
//  ChatViewController.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 06/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

protocol ChatViewControllerDelegate: class {
    func sendMessage(message: String)
}

class ChatViewController: UIViewController {
        
    @IBOutlet weak var messageTextField: UITextField!
    weak var delegate: ChatViewControllerDelegate?

    @IBAction func sendMessage(_ sender: Any) {
        guard let message = messageTextField.text else { return }
        delegate?.sendMessage(message: message)
    }

    let channel : Channel
    
    init(channel : Channel) {
        self.channel = channel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = channel.name

        // Do any additional setup after loading the view.
    }

}
