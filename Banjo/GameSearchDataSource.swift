//
//  GameSearchDataSource.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation
import UIKit

// MARK: - GameSearchDataSourceDelegate

protocol GameSearchDataSourceDelegate {
    func gameSearchDataSourceDidFetchGames(gameSearchDataSource: GameSearchDataSource)
    func gameSearchDataSource(_ gameSearchDataSource: GameSearchDataSource, didFailWithError error: Error)
}

// MARK: - GameSearchDataSource: NSObject

class GameSearchDataSource: NSObject {
    
    // MARK: Properties
    
    var games = [GamePartial]()
    var delegate: GameSearchDataSourceDelegate?
    
    // MARK: Get
    
    func fetchList(forQuery query: String) {
        IGDBService.shared.load(IGDBRequest.searchGames(query), type: [GamePartial].self) { (parse) in
            guard !parse.isCancelled else { return }
            
            if let results = parse.result as? [GamePartial] {
                self.games = results
                self.delegate?.gameSearchDataSourceDidFetchGames(gameSearchDataSource: self)
            } else {
                if let error = parse.error {
                    self.delegate?.gameSearchDataSource(self, didFailWithError: error)
                } else {
                    // FIXME: remove this code path
                    print("unknown error!")
                }
            }
        }
    }
    
    // MARK: Helpers
    
    func cancelSearch() {
        IGDBService.shared.cancelSearch()
    }
}

// MARK: - GameSearchDataSource: UITableViewDataSource

extension GameSearchDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameCell = tableView.dequeueReusableCellFromNib(forIndexPath: indexPath)
        
        let game = games[indexPath.row]
        cell.titleLabel.text = game.name
        let dateString = BanjoFormatter.shared.formatDateFromTimeIntervalSince1970(value: game.firstReleaseDate)
        cell.releaseDateLabel.text = dateString
        
        return cell
    }
}
