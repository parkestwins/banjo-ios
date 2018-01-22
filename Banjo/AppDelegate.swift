//
//  AppDelegate.swift
//  Banjo
//
//  Created by Jarrod Parkes on 7/18/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Kingfisher

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    
    var window: UIWindow?
    
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // configure dependencies
        Fabric.with([Crashlytics.self])        

        // setup image cache
        ImageCache.default.maxCachePeriodInSecond = 60 * 60 * 24 * 3 // 3 days
        
        // set global theme options
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().barTintColor = .banjoOrangeRed
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        // set main window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let startVC = StartVC.loadFromNib(bundle: Bundle.main)
        let nvc = UINavigationController(rootViewController: startVC)
        window?.rootViewController = nvc
        
        return true
    }
}
