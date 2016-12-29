//
//  AppDelegate.swift
//  Banjo
//
//  Created by Jarrod Parkes on 7/18/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import Firebase

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    
    var window: UIWindow?

    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        UIApplication.shared.statusBarStyle = .lightContent        
        return true
    }
}
