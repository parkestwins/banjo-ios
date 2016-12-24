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
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRealm()
    }
    
    // MARK: Setup
    
    func setupUI() {
        title = "N64 Games"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "gameCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    func setupRealm() {
        let username = "readonly@parkestwins.com"
        let password = "readonly"
        
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://127.0.0.1:9080")!) { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            DispatchQueue.main.async {
                // Open Realm
                var configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://127.0.0.1:9080/7e540a2f372c0e0946bd7672309f10c6/banjo")!),
                    readOnly: true
                )
                self.realm = try! Realm(configuration: configuration)
                
                // Show initial tasks
                func updateGames() {
                    if self.games.realm == nil, let platform = self.realm.objects(Platform.self).first {
                        self.games = platform.games
                    }
                    self.tableView.reloadData()
                }
                updateGames()
                
                // Notify us when Realm changes
//                self.notificationToken = self.realm.addNotificationBlock { _ in
//                    updateGames()
//                }
            }
        }
    }
    
    deinit {
        notificationToken.stop()
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
            let games = self.games
            try! games.realm?.write {
                games.insert(Game(value: ["title": title, "publisher": publisher]), at: 0)
            }                        
        })
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        do {
            try game.realm?.write {
                game.title = game.title + " MODIFIED!"
            }
        } catch {
            print("Error info: \(error)")
            
        }
    }
}
