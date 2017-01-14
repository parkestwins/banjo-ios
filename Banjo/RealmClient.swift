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

// MARK: - RealmClientError

enum RealmClientError: Error {
    case generateAnonymousUserFailed
}

// MARK: - RealmClient

class RealmClient {

    // MARK: Properties
    
    var token: RLMNotificationToken?
    
    var isSynced: Bool {
        return SyncUser.current != nil
    }
    var realm: Realm {
        return try! Realm(configuration: Realm.Configuration.defaultConfiguration)
    }
    var rlmRealm: RLMRealm {
        let configuration = toRLMConfiguration(configuration: Realm.Configuration.defaultConfiguration)
        return try! RLMRealm(configuration: configuration)
    }    
    
    // MARK: Sync Realm
    
    func syncRealm(completionHandler: @escaping (_ synced: Bool, _ error: Error?) -> Void) {
        if realmSynced() {
            // we're already synced before
            completionHandler(true, nil)
        } else {
            // never synced before, must login to sync
            authenticateWithCompletionHandler(completionHandler)
        }
    }
    
    func resyncRealm(completionHandler: @escaping (_ synced: Bool, _ error: Error?) -> Void) {
        SyncUser.current?.logOut()
        syncRealm(completionHandler: completionHandler)
    }
    
    private func realmSynced() -> Bool {
        // if user is authenticated and realm has been populated before, then user already synced
        if let user = SyncUser.current, UserDefaults.standard.bool(forKey: RealmConstants.Defaults.syncedBefore) {
            setConfigurationAndTokenWithUser(user)
            return true
        }
        // otherwise, user is not synced, try again
        return false
    }
            
    private func setConfigurationAndTokenWithUser(_ user: SyncUser) {
        // auth successful, save config, begin sync
        Realm.Configuration.defaultConfiguration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: RealmConstants.liveRealm)!))
        
        token = realm.addNotificationBlock { _ in
            NotificationCenter.default.post(name: Notification.Name(rawValue: RealmConstants.updateNotification), object: nil)
            UserDefaults.standard.set(true, forKey: RealmConstants.Defaults.syncedBefore)
        }
    }
    
    // MARK: Authenticate
    
    private func authenticateWithCompletionHandler(_ completionHandler: @escaping (_ synced: Bool, _ error: Error?) -> Void) {
        
        if let username = UserDefaults.standard.string(forKey: RealmConstants.Defaults.anonymousUsername) {
            logInWithCompletionHandler(anonymousUser: username, completionHandler)
        } else {
            // realm doesn't support anonymous (readonly) users yet, this is the workaround
            createAnonymousUserAndLoginWithCompletionHandler(retryAttempts: RealmConstants.retryAttempts, completionHandler)
        }
    }
    
    private func logInWithCompletionHandler(anonymousUser: String, _ completionHandler: @escaping (_ synced: Bool, _ error: Error?) -> Void) {
        
        SyncUser.logIn(with: .usernamePassword(username: anonymousUser, password: RealmConstants.anonymousPassword, register: false), server: URL(string: RealmConstants.liveServer)!) { user, error in
            
            guard let user = user else {
                completionHandler(false, error)
                return
            }
            
            DispatchQueue.main.async {
                self.setConfigurationAndTokenWithUser(user)
                completionHandler(true, nil)
            }
        }
        
    }
    
    private func createAnonymousUserAndLoginWithCompletionHandler(retryAttempts: Int, _ completionHandler: @escaping (_ synced: Bool, _ error: Error?) -> Void) {
        
        let attemptsLeft = retryAttempts - 1
        let anonymousUsername = NSUUID().uuidString
        
        SyncUser.logIn(with: .usernamePassword(username: anonymousUsername, password: RealmConstants.anonymousPassword, register: true), server: URL(string: RealmConstants.liveServer)!) { user, error in
            
            guard let user = user else {
                
                if let error = error as? NSError, (error.userInfo["statusCode"] as? Int) == 400 {
                    switch(error.code) {
                    case RLMSyncAuthError.userAlreadyExists.rawValue, RLMSyncAuthError.invalidCredential.rawValue:
                        if attemptsLeft > 0 {
                            self.createAnonymousUserAndLoginWithCompletionHandler(retryAttempts: attemptsLeft, completionHandler)
                            
                        } else {
                            completionHandler(false, RealmClientError.generateAnonymousUserFailed)
                        }
                        return
                    default:
                        break
                    }
                }
                
                completionHandler(false, error)
                return
            }
            
            DispatchQueue.main.async {
                UserDefaults.standard.set(anonymousUsername, forKey: RealmConstants.Defaults.anonymousUsername)
                self.setConfigurationAndTokenWithUser(user)
                completionHandler(true, nil)
            }
        }
    }
    
    // MARK: Utility
    
    private func toRLMConfiguration(configuration: Realm.Configuration) -> RLMRealmConfiguration {
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
