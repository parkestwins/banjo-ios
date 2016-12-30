//
//  AppDelegate.swift
//  Banjo
//
//  Created by Jarrod Parkes on 7/18/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    
    var window: UIWindow?
    
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        seedRealm()
        setupGlobalAppearances()
        return true
    }
    
    func setupGlobalAppearances() {
        UIApplication.shared.statusBarStyle = .lightContent
        //UINavigationBar.appearance().setTex
    }
    
    func seedRealm() {
        SyncUser.logIn(with: .usernamePassword(username: Constants.Realm.realmAdminUsername, password: Constants.Realm.realmAdminPassword, register: false), server: URL(string: Constants.Realm.realmServer)!) { user, error in
            guard let user = user else {
                print(String(describing: error))
                return
            }
            
            // open realm
            let configuration = Realm.Configuration(
                syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: Constants.Realm.realmBanjo)!)
            )
            let realm = try! Realm(configuration: configuration)
                        
            func getNewUniqueKey() -> String {
                return UUID.init().uuidString
            }
            
            // create platform
            let platform = Platform(value: ["id": "1", "name": "Nintendo 64", "abbreviation": "N64"])
            
            // create geo regions
            let europe = GeoRegion(value: ["id": "1", "abbreviation": "eu", "name": "Europe"])
            let latinAmerica = GeoRegion(value: ["id": "2", "abbreviation": "la", "name": "Latin America"])
            let southAmerica = GeoRegion(value: ["id": "3", "abbreviation": "sa", "name": "South America"])
            
            // create countries
            let unitedStates = Country(value: ["id": "1", "abbreviation": "us", "name": "United States"])
            let canada = Country(value: ["id": "2", "abbreviation": "ca", "name": "Canada"])
            let mexico = Country(value: ["id": "3", "abbreviation": "mx", "name": "Mexico"])
            let japan = Country(value: ["id": "4", "abbreviation": "jp", "name": "Japan"])
            
            // create release regions
            let ntscUC = ReleaseRegion(value: ["id": "1", "abbreviation": "NTSC-U/C"])
            ntscUC.countries.append(objectsIn: [unitedStates, canada, mexico])
            ntscUC.geoRegions.append(latinAmerica)
            let jp = ReleaseRegion(value: ["id": "2", "abbreviation": "JP"])
            ntscUC.countries.append(japan)
            
            // create ratings
            let everyoneRating = Rating(value: ["id": "1", "abbreviation": "E", "shortDescription": "Everyone", "longDescription": "Content is generally suitable for all ages. May contain minimal cartoon, fantasy or mild violence and/or infrequent use of mild language."])
            
            // create genres
            let action = Genre(value: ["id": "1", "name": "Action", "colorHex": "ce3c11"])
            let adventure = Genre(value: ["id": "2", "name": "Adventure", "colorHex": "70ac30"])
            
            // create releases
            let zelda = Game(value: ["id": "1", "title": "The Legend of Zelda: Ocarina of Time"])
            zelda.genres.append(objectsIn: [action, adventure])
            
            let zeldaJP = Release(value: ["id": "1", "specialTitle": "Zelda no Densetsu: Toki no Ocarina", "date": "11/21/98".toNSDate()!, "publisher": "Nintendo", "developer": "Nintendo", "coverImagePath": "gs://banjo-21ba1.appspot.com/zelda-jp-11-21-98.jpg", "summary": "As a young boy, Link is tricked by Ganondorf, the King of the Gerudo Thieves. The evil human uses Link to gain access to the Sacred Realm, where he places his tainted hands on Triforce and transforms the beautiful Hyrulean landscape into a barren wasteland. Link is determined to fix the problems he helped to create, so with the help of Rauru he travels through time gathering the powers of the Seven Sages."])
            zeldaJP.game = zelda
            zeldaJP.rating = everyoneRating
            zeldaJP.releaseRegion = jp
            
            let zeldaUS1 = Release(value: ["id": "2", "date": "11/23/98".toNSDate()!, "publisher": "Nintendo", "developer": "Nintendo", "coverImagePath": "gs://banjo-21ba1.appspot.com/zelda-us-11-23-98.jpg", "summary": "As a young boy, Link is tricked by Ganondorf, the King of the Gerudo Thieves. The evil human uses Link to gain access to the Sacred Realm, where he places his tainted hands on Triforce and transforms the beautiful Hyrulean landscape into a barren wasteland. Link is determined to fix the problems he helped to create, so with the help of Rauru he travels through time gathering the powers of the Seven Sages."])
            zeldaUS1.game = zelda
            zeldaUS1.rating = everyoneRating
            zeldaUS1.releaseRegion = ntscUC
            
            let zeldaUS2 = Release(value: ["id": "3", "specialTitle": "##Collector's Edition", "date": "11/24/98".toNSDate()!, "publisher": "Nintendo", "developer": "Nintendo", "coverImagePath": "gs://banjo-21ba1.appspot.com/zelda-us-11-24-98.jpg", "summary": "As a young boy, Link is tricked by Ganondorf, the King of the Gerudo Thieves. The evil human uses Link to gain access to the Sacred Realm, where he places his tainted hands on Triforce and transforms the beautiful Hyrulean landscape into a barren wasteland. Link is determined to fix the problems he helped to create, so with the help of Rauru he travels through time gathering the powers of the Seven Sages."])
            zeldaUS2.game = zelda
            zeldaUS2.rating = everyoneRating
            zeldaUS2.releaseRegion = ntscUC
            
            let releases = [zeldaJP, zeldaUS1, zeldaUS2]
            zelda.releases.append(objectsIn: releases)
            
            do {
                try realm.write {
                    realm.add(platform, update: true)
                    realm.add([europe, latinAmerica, southAmerica], update: true)
                    realm.add([unitedStates, canada, mexico, japan], update: true)
                    realm.add([ntscUC, jp], update: true)
                    realm.add([action, adventure], update: true)
                    realm.add(releases, update: true)
                    realm.add(zelda, update: true)
                }
            } catch {
                print("error info: \(error)")
            }
        }
    }
}
