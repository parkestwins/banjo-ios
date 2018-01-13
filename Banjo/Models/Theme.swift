//
//  Theme.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - Theme: Int, Codable

enum Theme: Int, Codable {
    case action = 1
    case fantasy = 17
    case scienceFiction
    case horror
    case thriller
    case survival
    case historical
    case stealth
    case comedy = 27
    case business
    case drama = 31
    case nonFiction
    case sandbox
    case educational
    case kids
    case openWorld = 38
    case warfare
    case party
    case fourX // explore, expand, exploit, and exterminate
    case erotic
    case mystery
}
