//
//  GameDetailDataSource.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - GameDetailDataSource: BaseCollectionDataSource

class GameDetailDataSource: BaseCollectionDataSource {
    
    // MARK: Properties
    
    var gameID: Int?
    var game: Game?
    var gameDetailCell: GameDetailCell?
    
    // MARK: BaseCollectionDataSource
    
    override func reload(completion: @escaping (AnyObject?) -> (), error: @escaping (Error?) -> ()) {
        guard let gameID = gameID else { return }
        
        IGDBService.shared.load(IGDBRequest.getGameExpanded(gameID), type: [Game].self) { (parse) in
            guard !parse.isCancelled else { return }
            
            if let games = parse.result as? [Game] {
                self.game = games[0]
                self.state = .normal
                completion(nil)
            } else {
                error(parse.error)                
            }
        }
    }
    
    override func dataSourceCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func dataSourceCollectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: GameDetailHeaderCell = collectionView.dequeueReusableSupplementaryViewFromNib(ofKind: UICollectionElementKindSectionHeader, forIndexPath: indexPath)
        
        guard let game = game else { return header }
        
        header.coverLoadingIndicator.startAnimating()
        header.coverLoadingIndicator.isHidden = false
        
        if let cover = game.cover {
            let filePath = cover.url as NSString
            let fileExtension = filePath.pathExtension
            
            if let coverURL = URL(string: "https://images.igdb.com/igdb/image/upload/\(cover.cloudinaryID).\(fileExtension)") {
                SimpleCache.shared.getImage(withURL: coverURL) { (image, error) in
                    if let image = image {
                        self.setCoverImageForCell(header, image: image)
                    } else if let _ = error {
                        self.setCoverImageForCell(header, image: #imageLiteral(resourceName: "no-cover"))
                    }
                }
            } else {
                self.setCoverImageForCell(header, image: #imageLiteral(resourceName: "no-cover"))
            }
        } else {
            self.setCoverImageForCell(header, image: #imageLiteral(resourceName: "no-cover"))
        }        
        
        return header
    }
    
    private func setCoverImageForCell(_ header: GameDetailHeaderCell, image: UIImage) {
        header.coverLoadingIndicator.stopAnimating()
        header.coverLoadingIndicator.isHidden = true
        header.coverImageView.image = image
    }
    
    override func dataSourceCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GameDetailCell = collectionView.dequeueReusableCellFromNib(forIndexPath: indexPath)
        
        guard let game = game else { return cell }
        
        cell.developerLabel.text = game.developersString
        cell.publisherLabel.text = game.publishersString
        cell.summaryLabel.text = game.summary ?? "Summary does not exist."
        cell.summaryLabel.numberOfLines = 0
        cell.titleLabel.text = game.name
        cell.releaseDateLabel.text = BanjoFormatter.shared.formatDateFromTimeIntervalSince1970(value: game.firstReleaseDate)

        cell.ratingFieldLabel.text = "ESRB Rating"
        cell.ratingLabel.text = game.esrb?.rating.name ?? "N/A"

        // FIXME: currently using last game mode to determine player image
        if let gameModes = game.gameModes {
            cell.playersImage.image = gameModes[gameModes.count - 1].image
        } else {
            cell.playersImage.image = #imageLiteral(resourceName: "single")
        }
        cell.playersImage.tintColor = .banjoSlate
        
        return cell
    }
}
