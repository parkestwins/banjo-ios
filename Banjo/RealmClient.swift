//
//  RealmClient.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/7/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import Foundation
import RealmSwift

class RealmClient {
    
    class func syncRealm(completionHandler: @escaping (Error?) -> Void) {
        
        SyncUser.logIn(with: .usernamePassword(username: RealmConstants.username, password: RealmConstants.password, register: false), server: URL(string: RealmConstants.testServer)!) { user, error in
            guard let user = user else {
                completionHandler(error)
                return
            }
            
            DispatchQueue.main.async {
                Realm.Configuration.defaultConfiguration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: RealmConstants.testRealm)!))
                completionHandler(nil)                
            }
        }
        
    }
    
}

//SyncUser.logIn(with: .usernamePassword(username: Constants.Realm.realmUsername, password: Constants.Realm.realmPassword, register: false), server: URL(string: Constants.Realm.testRealmServer)!) { user, error in
//    guard let user = user else {
//        print(String(describing: error))
//        return
//    }
//    
//    DispatchQueue.main.async {
//        Realm.Configuration.defaultConfiguration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: Constants.Realm.testRealmBanjo)!))
//        self.performSegue(withIdentifier: "login", sender: self)
//    }
//}
