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
    func sendMessage(message: String?, url: URL?, type: Type)
    func sendImage(image: UIImage)
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
        setSendButtonAppearance(text: "")
        messageInputBar.sendButton.isEnabled = true
    }
    
    func addMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
    }
    
    func showPicker(with source: UIImagePickerController.SourceType) {
        
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func sendImage() {
        
        let alertController = UIAlertController(title: "Seleziona la sorgente", message: "", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            
            self.showPicker(with: .camera)
        }
        
        let gallery = UIAlertAction(title: "Gallery", style: .default) { _ in
            
            self.showPicker(with: .photoLibrary)
        }
        
        let saved = UIAlertAction(title: "Saved photo album", style: .default) { _ in
            
            self.showPicker(with: .savedPhotosAlbum)
        }
    
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(gallery)
        alertController.addAction(saved)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
        
    }
    
    private func setSendButtonAppearance(text: String) {
        if text.isEmpty {
            messageInputBar.sendButton.image = UIImage(systemName: "camera.fill")
            messageInputBar.sendButton.title = ""
        } else {
            messageInputBar.sendButton.image = nil
            messageInputBar.sendButton.title = "Send"
        }
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
    
    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
     
        guard let message = message as? Message, message.type == .photo, let photo = message.photo else { return }
        
        imageView.kf.setImage(with: photo.url)
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        if text.isEmpty {
            sendImage()
        } else {
            self.delegate?.sendMessage(message: text, url: nil, type: .text)
            inputBar.inputTextView.text = ""
            inputBar.sendButton.isEnabled = true
            
            DispatchQueue.main.async {
                
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom()
            }
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        setSendButtonAppearance(text: text)
    }
}

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        defer {
            dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        delegate?.sendImage(image: image)
        
    }
    
}
