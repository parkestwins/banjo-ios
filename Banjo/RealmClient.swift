//
//  RealmClient.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/7/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - RealmClient

class RealmClient {
    
    // FIXME: Add notification layer that dispatches messages to any listeners
    
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
