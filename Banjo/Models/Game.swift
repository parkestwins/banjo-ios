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
    let summary: String?
    let category: GameCategory?
    let playerPerspectives: [PlayerPerspective]?
    let gameModes: [GameMode]?
    let developers: [Developer]?
    let publishers: [Publisher]?
    let genres: [Genre]?
    let themes: [Theme]?
    let firstReleaseDate: Int
    let releaseDates: [ReleaseDate]?
    let screenshots: [IGDBImage]?
    let cover: IGDBImage?
    let esrb: ESRB?
    let pegi: PEGI?
    
    var developersString: String {
        guard let developers = developers else { return "N/A" }
        
        return developers.reduce("") { (result, developer) -> String in
            if result == "" {
                return result + (developer.name ?? "")
            } else {
                return result + ", " + (developer.name ?? "")
            }            
        }
    }
    
    var publishersString: String {
        guard let publishers = publishers else { return "N/A" }
        
        return publishers.reduce("") { (result, publisher) -> String in
            if result == "" {
                return result + (publisher.name ?? "")
            } else {
                return result + ", " + (publisher.name ?? "")
            }
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
