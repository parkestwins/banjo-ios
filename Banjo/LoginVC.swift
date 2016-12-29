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
        let username = "readonly@parkestwins.com"
        let password = "readonly"
        
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://127.0.0.1:9080")!) { user, error in
            guard let user = user else {
                print(String(describing: error))
                return
            }
                                    
            DispatchQueue.main.async {
                Realm.Configuration.defaultConfiguration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://127.0.0.1:9080/7e540a2f372c0e0946bd7672309f10c6/banjo")!), readOnly: true)
                self.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
}
