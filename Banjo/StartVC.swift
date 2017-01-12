//
//  StartVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - StartVCState

enum StartVCState {
    case startSync
    case cannotSync
    case synced
}

// MARK: - StartVC: UIViewController

class StartVC: UIViewController {
    
    // MARK: Properties
    
    var reachability = Reachability.networkReachabilityForInternetConnection()
    
    // MARK: Outlets
    
    @IBOutlet weak var searchGamesButton: UIButton!    
    @IBOutlet weak var syncStatusLabel: UILabel!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start listening for reachability changes
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
        _ = reachability?.startNotifier()
        
        syncRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: Actions
    
    @IBAction func startSearching(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    // MARK: Setup UI
    
    func setupUI(forState: StartVCState) {
        switch (forState) {
        case .startSync:
            searchGamesButton.setTitle("Initializing Database...", for: .normal)
            searchGamesButton.isEnabled = false
        case .cannotSync:
            searchGamesButton.isEnabled = false
            searchGamesButton.setTitle("Error Initializing...", for: .disabled)
            syncStatusLabel.text = "Please connect to a network. Once connected, the database will begin initializing automatically."
            displayAlert(title: "Database Initialization Failed.", message: "To resolve, please connect to a network. Once connected, the database will begin initializing automatically.")
        case .synced:
            syncStatusLabel.text = ""
            searchGamesButton.setTitle("Search N64 Database...", for: .normal)
            searchGamesButton.isEnabled = true
        }
    }
    
    // MARK: Alert
    
    private func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Deinitializer
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability?.stopNotifier()
    }
    
    // MARK: Reachability
    
    func reachabilityDidChange(_ notification: Notification) {
        guard let reachability = reachability else { return }
        if reachability.isReachable {
            // if never synced before, try syncing for the first time
            if !RealmClient.shared.isSynced {
                syncRealm()
            } else {
                // otherwise, resync (logout, then login) to continue getting updates
                RealmClient.shared.resyncRealm { (synced, error) in
                    if let error = error {
                        // fail silently, this could be called from anywhere
                        print(error)
                    }
                    if synced == true {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: RealmConstants.updateNotification), object: nil)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Sync Realm
    
    func syncRealm() {
        if let _ = RealmClient.shared.token {
            setupUI(forState: .synced)
        } else {
            setupUI(forState: .startSync)
            RealmClient.shared.syncRealm { (synced, error) in
                DispatchQueue.main.async {
                    if let _ = error, synced == false {
                        self.setupUI(forState: .cannotSync)
                    } else {
                        self.setupUI(forState: .synced)
                    }
                }
            }
        }
    }
}
