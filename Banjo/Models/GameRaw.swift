//
//  GameRaw.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - GameRaw: Codable

struct GameRaw: Codable {
    let id: Int
    let name: String
    let slug: String
    let url: String
    let createdAt: Int
    let updatedAt: Int
    let summary: String
    let collection: Int
    let franchise: Int
    let franchises: [Int]
    let hypes: Int
    let rating: Double
    let popularity: Int
    let aggregatedRating: Int
    let aggregatedRatingCount: Int
    let totalRating: Double
    let totalRatingCount: Int
    let ratingCount: Int
    let games: [Int]
    let tags: [Int]
    let developers: [Int]
    let publishers: [Int]
    let category: GameCategory
    let timeToBeat: TimeToBeat
    let playerPerspectives: [PlayerPerspective]
    let gameModes: [GameMode]
    let keywords: [Int]
    let themes: [Theme]
    let genres: [Genre]
    let firstReleaseDate: Int
    let pulseCount: Int
    let platforms: [Platform]
    let releaseDates: [ReleaseDate]
    let alternativeNames: [AlternativeName]
    let screenshots: [IGDBImage]
    let cover: IGDBImage
    let esrb: ESRB
    let pegi: PEGI
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case summary
        case collection
        case franchise
        case franchises
        case hypes
        case rating
        case popularity
        case aggregatedRating = "aggregated_rating"
        case aggregatedRatingCount = "aggregated_rating_count"
        case totalRating = "total_rating"
        case totalRatingCount = "total_rating_count"
        case ratingCount = "rating_count"
        case games
        case tags
        case developers
        case publishers
        case category
        case timeToBeat = "time_to_beat"
        case playerPerspectives = "player_perspectives"
        case gameModes = "game_modes"
        case keywords
        case themes
        case genres
        case firstReleaseDate = "first_release_date"
        case pulseCount = "pulse_count"
        case platforms
        case releaseDates = "release_dates"
        case alternativeNames = "alternative_names"
        case screenshots
        case cover
        case esrb
        case pegi
    }
}
