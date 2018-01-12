//
//  GameMode.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - GameMode: Int, Codable

enum GameMode: Int, Codable {
    case single = 1
    case multi
    case coop
    case splitScreen
    case mmo
}
