//
//  RealmTestVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - RealmTestVC: UITableViewController

class RealmTestVC: UITableViewController {
    
    // MARK: Property
    
    var games = List<Game>()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: UI
    
    func setupUI() {
        title = "N64 Games"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "gameCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        let game = games[indexPath.row]
        cell.textLabel?.text = game.title
        return cell
    }
    
    // MARK: Functions
    
    func add() {
        let alertController = UIAlertController(title: "New Game", message: "Enter Game Info", preferredStyle: .alert)
        var titleTextField: UITextField!
        var publisherTextField: UITextField!
        alertController.addTextField { textField in
            titleTextField = textField
            textField.placeholder = "Title"
        }
        alertController.addTextField { textField in
            publisherTextField = textField
            textField.placeholder = "Publisher"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let title = titleTextField.text, !title.isEmpty else { return }
            guard let publisher = publisherTextField.text, !publisher.isEmpty else { return }
            self.games.append(Game(value: ["title": title, "publisher": publisher]))
            self.tableView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }
}
