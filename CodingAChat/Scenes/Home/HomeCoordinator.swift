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
    
    private let window: UIWindow
    
    init(window: UIWindow, user: User) {
        self.window = window
        self.user = user
        self.homeViewController = HomeViewController()
        self.navigator = UINavigationController(rootViewController: homeViewController)
    }
    
    func start() {
        homeViewController.delegate = self
        window.rootViewController = navigator
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func channelJoin(selectedChannel: Channel) {
        let chatcoordinator = ChatCoordinator(presenter: homeViewController, window: window, channel: selectedChannel, user: user)
        chatcoordinator.start()
        childCoordinators.append(chatcoordinator)
    }
    
        
   
    func onEditDetailsAction() {
        let editCoordinator = EditDetailsCoordinator(presenter: homeViewController, user: user)
        editCoordinator.start()
        childCoordinators.append(editCoordinator)
    }
    
    func fetchData() {
        let db = Firestore.firestore()
        
        db.collection("channels").addSnapshotListener() { [weak self] (querySnapshot, err) in
            
            if let err = err {
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
