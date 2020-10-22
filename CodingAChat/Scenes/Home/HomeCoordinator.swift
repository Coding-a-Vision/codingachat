//
//  HomeCoordinator.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigator: UINavigationController
    let homeViewController: HomeViewController
    private let user: User
    private let tracker: Trackable
    private let window: UIWindow
    
    init(window: UIWindow, user: User, tracker: Trackable) {
        self.window = window
        self.user = user
        self.tracker = tracker
        self.homeViewController = HomeViewController()
        self.navigator = WhiteNavigationController(rootViewController: homeViewController)
    }
    
    func start() {
        homeViewController.delegate = self
        window.rootViewController = navigator
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    
    func onSettings() { 
        let settingCoordinator = SettingsCoordinator(presenter: homeViewController, tracker: tracker)
        settingCoordinator.start()
        childCoordinators.append(settingCoordinator)
    }
    
    func channelJoin(selectedChannel: Channel) {
        let chatcoordinator = ChatCoordinator(presenter: homeViewController, channel: selectedChannel, user: user)
        chatcoordinator.start()
        childCoordinators.append(chatcoordinator)
        tracker.track(withName: .join, parameters: ["channelID": selectedChannel.name])
    }
    
    func onEditDetailsAction() {
        let editCoordinator = EditDetailsCoordinator(presenter: homeViewController, user: user, tracker: tracker)
        editCoordinator.start()
        childCoordinators.append(editCoordinator)
    }
    
    func addChannel(channel: String) {
        
        let db = Firestore.firestore()
        db.collection("channels").addDocument(data: ["name" : channel])
    }
    
    func fetchData() {
        let db = Firestore.firestore()
        db.collection("channels").addSnapshotListener { [weak self] (querySnapshot, err) in
            if let err = err {
                UIAlertController.show(message: "Unable to load channels")
                print("Error getting documents: \(err)")
            } else if let snapshot = querySnapshot {
                var items: [Channel] = []
                for document in snapshot.documents {
                    let dict = document.data()
                    if let itemName = dict["name"] as? String {
                        let channel = Channel(id: document.documentID, name: itemName)
                        items.append(channel)    
                    }
                }
                
                self?.homeViewController.items = items
            }
        }
    }
}

struct Channel {
    let id: String
    let name: String
}
