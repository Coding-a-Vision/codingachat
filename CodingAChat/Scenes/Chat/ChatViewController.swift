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
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    weak var delegate: ChatViewControllerDelegate?
    var messages: Set<Message> = [] {
        didSet {
            tableView.reloadData()
        }
    }

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
        self.tableView.dataSource = self
        self.title = channel.name
        let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cellId")
        
        // Do any additional setup after loading the view.
    }

}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = Array(messages)[indexPath.row].message
        return cell
    }
    
    
}
