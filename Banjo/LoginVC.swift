//
//  LoginVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import RealmSwift

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRealm()
    }
    
    func setupRealm() {
        
        SyncUser.logIn(with: .usernamePassword(username: Constants.Realm.realmUsername, password: Constants.Realm.realmPassword, register: false), server: URL(string: Constants.Realm.realmServer)!) { user, error in
            guard let user = user else {
                print(String(describing: error))
                return
            }
                                    
            DispatchQueue.main.async {
                Realm.Configuration.defaultConfiguration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: Constants.Realm.realmBanjo)!))
                self.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
}
