//
//  ReleaseDate.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - ReleaseDate: Codable

struct ReleaseDate: Codable {
    let category: GameCategory
    let platform: Platform
    let date: Int?
    let region: Region?
    let human: String
    let year: Int?
    let month: Int?
    
    enum CodingKeys: String, CodingKey {
        case category
        case platform
        case date
        case region
        case human
        case year = "y"
        case month = "m"
    }
}
