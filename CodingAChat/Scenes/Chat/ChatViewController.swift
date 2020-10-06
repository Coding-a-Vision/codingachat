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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
