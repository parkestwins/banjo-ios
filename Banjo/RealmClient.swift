//
//  RealmClient.swift
//  Banjo
//
//  Code snippet by Hector Matos.
//  Hector: krakendev.io/blog/the-right-way-to-write-a-singleton/
//
//  Created by Jarrod Parkes on 01/07/16.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import Realm
import Foundation
import RealmSwift
import Realm.Dynamic

// MARK: - RealmClient

class RealmClient {

    // MARK: Notification Tokens
    
    var token: RLMNotificationToken?
    
    // MARK: Realms
    
    var realm: Realm {
        return try! Realm(configuration: Realm.Configuration.defaultConfiguration)
    }
    var rlmRealm: RLMRealm {
        let configuration = toRLMConfiguration(configuration: Realm.Configuration.defaultConfiguration)
        return try! RLMRealm(configuration: configuration)
    }
    
    // MARK: Sync to Realm
    
    func syncToRealm(completionHandler: @escaping (Error?) -> Void) {
                        
        SyncUser.logIn(with: .usernamePassword(username: RealmConstants.username, password: RealmConstants.password, register: false), server: URL(string: RealmConstants.liveServer)!) { user, error in
            guard let user = user else {
                completionHandler(error)
                return
            }
            
            DispatchQueue.main.async {
                Realm.Configuration.defaultConfiguration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: RealmConstants.liveRealm)!))
                
                // notify us when the realm changes
                self.token = self.realm.addNotificationBlock { _ in
                    NotificationCenter.default.post(name: Notification.Name(rawValue: RealmConstants.updateNotification), object: nil)
                }
                
                completionHandler(nil)                
            }
        }
    }
    
    // MARK: Utility
    
    func toRLMConfiguration(configuration: Realm.Configuration) -> RLMRealmConfiguration {
        let rlmConfiguration = RLMRealmConfiguration()
        if configuration.fileURL != nil {
            rlmConfiguration.fileURL = configuration.fileURL
        }
        
        if configuration.inMemoryIdentifier != nil {
            rlmConfiguration.inMemoryIdentifier = configuration.inMemoryIdentifier
        }
        
        if configuration.syncConfiguration != nil {
            rlmConfiguration.syncConfiguration = RLMSyncConfiguration(user: (configuration.syncConfiguration?.user)!, realmURL: (configuration.syncConfiguration?.realmURL)!)
        }
        rlmConfiguration.encryptionKey = configuration.encryptionKey
        rlmConfiguration.readOnly = configuration.readOnly
        rlmConfiguration.schemaVersion = configuration.schemaVersion
        return rlmConfiguration
    }
        
    // MARK: Singleton
    
    static let shared = RealmClient()
    
    // private init() prevents others from using the default '()' initializer
    private init() {}
    
    deinit {
        token?.stop()
    }
}
