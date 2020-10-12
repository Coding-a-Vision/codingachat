//
//  ChatViewController.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 06/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import MessageKit
import FirebaseAuth
import InputBarAccessoryView

protocol ChatViewControllerDelegate: class {
    func sendMessage(message: String, type: Type)
}

class ChatViewController: MessagesViewController {
    
    weak var delegate: ChatViewControllerDelegate?
    private var messages: [Message] = []
    private let user: User
    
    private var sortedMessages: [Message] {
        return messages.sorted { (m1, m2) -> Bool in
            return m1.date < m2.date
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        //guard let message = messageTextField.text else { return }
        //delegate?.sendMessage(message: message, type: .text)
    }
    
    let channel : Channel
    
    init(channel : Channel, user: User) {
        self.channel = channel
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = channel.name
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    
    func addMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
    }
}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Author(senderId: user.uid, displayName: user.displayName ?? user.email ?? "Anonymous")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        let message = sortedMessages[indexPath.section]
        return message
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return sortedMessages.count
    }
}

extension ChatViewController: MessagesLayoutDelegate {}

extension ChatViewController: MessagesDisplayDelegate {
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        guard let message = message as? Message else { return }
        
        if let urlString = message.userPictureUrl, let url = URL(string: urlString) {
            avatarView.kf.setImage(with: url)
        } else {
            avatarView.initials = String(message.author.displayName.prefix(2))
        }
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        self.delegate?.sendMessage(message: text, type: .text)
        inputBar.inputTextView.text = ""
    }
}
