//
//  HomeViewController.swift
//  CodingAChat
//
//  Created by Samuele Francesco Rizzo on 29/09/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func onEditDetailsAction()
    func fetchData()
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "ChannelTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "cellID")
        }
    }
    
    
    
    var items: [Channel] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(editDetailsAction))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.fetchData()
    }
    
    @objc
    private func editDetailsAction() {
        delegate?.onEditDetailsAction()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! ChannelTableViewCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {}
