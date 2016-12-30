//
//  RealmTestVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

// MARK: - RealmTestVC: UITableViewController

class RealmTestVC: UITableViewController {
    
    // MARK: Property
    
    var games = List<Game>()
    var notificationToken: NotificationToken!
    var realm: Realm!    
    private let reuseIdentifier = "gameCell"
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRealm()
        testFirebaseStorage()
    }
    
    // MARK: Setup
    
    func setupUI() {
        title = "N64 Games"
        let gameCellNib = UINib(nibName: "GameCell", bundle: nil)
        tableView.register(gameCellNib, forCellReuseIdentifier: reuseIdentifier)        
    }
    
    func setupRealm() {
        
        SyncUser.logIn(with: .usernamePassword(username: Constants.Realm.realmUsername, password: Constants.Realm.realmPassword, register: false), server: URL(string: Constants.Realm.realmServer)!) { user, error in
            guard let user = user else {
                print(String(describing: error))
                return
            }
            
            DispatchQueue.main.async {
                // Open Realm
                var configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: Constants.Realm.realmBanjo)!)
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
                self.notificationToken = self.realm.addNotificationBlock { _ in
                    updateGames()
                }
            }
        }
    }
    
    func testFirebaseStorage() {
        let imageURL = "gs://banjo-21ba1.appspot.com/jarrod-mii.png"
        if imageURL.hasPrefix("gs://") {
            FIRStorage.storage().reference(forURL: imageURL).data(withMaxSize: INT64_MAX){ (data, error) in
                if let error = error {
                    print("Error downloading: \(error)")
                    return
                }
                let image = UIImage.init(data: data!)
                print(image.debugDescription)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let gameCell = cell as? GameCell {
            let game = games[indexPath.row]
            gameCell.titleLabel.text = game.title
            gameCell.releaseLabel.text = "Release Date"            
        }
        return cell
    }
}
