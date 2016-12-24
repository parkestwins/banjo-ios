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
        let username = "admin@parkestwins.com"
        let password = "rd3s1gne"
        
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://127.0.0.1:9080")!) { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
                                    
            DispatchQueue.main.async {
                Realm.Configuration.defaultConfiguration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://127.0.0.1:9080/~/banjo")!))
                self.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
}
