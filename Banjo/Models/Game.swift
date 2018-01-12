//
//  Game.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - Game: Codable

struct Game: Codable {
    let id: Int
    let name: String
    let summary: String
    let category: GameCategory
    let playerPerspectives: [PlayerPerspective]
    let gameModes: [GameMode]
    let developers: [Developer]
    let publishers: [Publisher]
    let genres: [Genre]
    let themes: [Theme]
    let firstReleaseDate: Int
    let releaseDates: [ReleaseDate]
    let screenshots: [Cover]
    let cover: Cover
    let esrb: ESRB
    let pegi: PEGI
    
    var developersString: String {
        return developers.reduce("") { (result, developer) -> String in
            return result + (developer.name ?? "")
        }
    }
    
    var publishersString: String {
        return publishers.reduce("") { (result, publisher) -> String in
            return result + (publisher.name ?? "")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case summary
        case category
        case playerPerspectives = "player_perspectives"
        case gameModes = "game_modes"
        case developers
        case publishers
        case themes
        case genres
        case firstReleaseDate = "first_release_date"
        case releaseDates = "release_dates"
        case screenshots
        case cover
        case esrb
        case pegi
    }        
}
