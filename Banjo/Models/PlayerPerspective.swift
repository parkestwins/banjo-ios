//
//  PlayerPerspective.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - PlayerPerspective: Int, Codable

enum PlayerPerspective: Int, Codable {
    case firstPerson = 1
    case thirdPerson
    case birdView
    case sideView
    case text
    case aural
    case virtualReality
}
