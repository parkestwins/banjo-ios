//
//  StartVC.swift

//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - SyncVC: UIViewController

class StartVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var searchGamesButton: UIButton!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchGamesButton.isEnabled = false
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
    
    // MARK: Setup
    
    func syncRealm() {
        
        RealmClient.syncRealm { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.searchGamesButton.isEnabled = true
            }
        }
    }
}
