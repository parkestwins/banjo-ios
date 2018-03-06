//
//  GameCategory.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - GameCategory: Int, Codable

enum GameCategory: Int, Codable {
    case mainGame
    case dlcAddOn
    case expansion
    case bundle
    case standaloneExpansion
    case unknown5
    case unknown6
    case unknown7
}
