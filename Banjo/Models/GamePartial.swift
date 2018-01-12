//
//  GamePartial.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - GamePartial: Codable

struct GamePartial: Codable {
    let id: Int
    let name: String
    let firstReleaseDate: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstReleaseDate = "first_release_date"
    }
}
