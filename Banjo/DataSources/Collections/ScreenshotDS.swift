//
//  ScreenshotDS.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - ScreenshotDS: BaseCollectionDS

class ScreenshotDS: BaseCollectionDS {
    
    // MARK: Properties
    
    var game: Game?
    
    // MARK: BaseCollectionDS
    
    override func reload(completion: @escaping (AnyObject?) -> (), error: @escaping (Error?) -> ()) {}
    
    override func dataSourceCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game?.screenshots?.count ?? 0
    }

    override func dataSourceCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ScreenshotCell = collectionView.dequeueReusableCellFromNib(forIndexPath: indexPath)
        
        guard let game = game, let screenshots = game.screenshots else { return cell }
        
        cell.loadingIndicator.startAnimating()
        cell.loadingIndicator.isHidden = false
                
        let screenshot = screenshots[indexPath.row]
        let filePath = screenshot.url as NSString
        let fileExtension = filePath.pathExtension
        
        let urlString = "https://images.igdb.com/igdb/image/upload/t_screenshot_big/\(screenshot.cloudinaryID).\(fileExtension)"
        cell.imageView.imageFromCache(urlString)
        
        return cell
    }
}
