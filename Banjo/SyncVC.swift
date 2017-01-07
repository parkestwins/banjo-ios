//
//  SyncVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - SyncVC: UIViewController

class SyncVC: UIViewController {
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncRealm()
    }
    
    // MARK: Setup
    
    func syncRealm() {
        
        RealmClient.syncRealm { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
}
