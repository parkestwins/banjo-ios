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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FIRApp.configure()    
        return true
    }
}