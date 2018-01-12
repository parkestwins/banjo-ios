//
//  SimpleCache.swift
//  Banjo
//
//  Various code snippets by Chris Hulbert and Hector Matos.
//  Chris: splinter.com.au/2015/09/24/swift-image-cache/
//  Hector: krakendev.io/blog/the-right-way-to-write-a-singleton/
//
//  Created by Jarrod Parkes on 01/08/16.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import Foundation
import SDWebImage

// MARK: - SimpleCache

class SimpleCache {

    // MARK: Properties
    
    private let imageCache = SDImageCache.shared()
    private let cachedEnabled = true
    
    // MARK: In-Memory Image Caching    
    
    func getImage(withURL url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        if let cachedImage = imageCache.imageFromCache(forKey: url.absoluteString), cachedEnabled == true {
            completionHandler(cachedImage, nil)
        } else {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completionHandler(nil, error)
                    }
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    self.imageCache.store(image, forKey: url.absoluteString, completion: nil)
                    DispatchQueue.main.async { completionHandler(image, nil) }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(nil, NSError(domain: "no data for image at \(url.absoluteString)", code: 0, userInfo: nil))
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: Singleton
    
    static let shared = SimpleCache()
    
    // private init() prevents others from using the default '()' initializer
    private init() {}
}
