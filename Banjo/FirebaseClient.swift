//
//  FirebaseClient.swift
//  Banjo
//
//  Various code snippets by Chris Hulbert and Hector Matos.
//  Chris: splinter.com.au/2015/09/24/swift-image-cache/
//  Hector: krakendev.io/blog/the-right-way-to-write-a-singleton/
//
//  Created by Jarrod Parkes on 01/08/16.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import Firebase
import Foundation

// MARK: - FirebaseStorageError: Error

enum FirebaseStorageError: Error {
    case fileNotOnFirebase(String)
    case fileNoData(String)
}

// MARK: - FirebaseClient

class FirebaseClient {

    // MARK: Properties
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let cachedEnabled = true
    
    // MARK: Config
    
    func configure() {
        FIRApp.configure()
    }
    
    // MARK: In-Memory Image Caching    
    
    func getImage(path: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        if let cachedImage = imageCache.object(forKey: path as NSString), cachedEnabled == true {
            completionHandler(cachedImage, nil)
        } else {
            FIRStorage.storage().reference(forURL: path).data(withMaxSize: INT64_MAX){ (data, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completionHandler(nil, FirebaseStorageError.fileNotOnFirebase(error.localizedDescription))
                    }
                    return
                }
                if let data = data {
                    let downloadedImage = UIImage(data: data)!
                    self.imageCache.setObject(downloadedImage, forKey: path as NSString, cost: data.count)
                    DispatchQueue.main.async {
                        completionHandler(downloadedImage, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(nil, FirebaseStorageError.fileNoData("no data for image at \(path)"))
                    }
                }
            }
        }
    }
    
    // MARK: Singleton
    
    static let shared = FirebaseClient()
    
    // private init() prevents others from using the default '()' initializer
    private init() {
        imageCache.name = FirebaseConstants.imageCacheName
        imageCache.countLimit = 1000
        imageCache.totalCostLimit = 10 * 1024 * 1024 // max 10MB        
    }
}
