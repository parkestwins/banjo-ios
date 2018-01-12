//
//  Genre.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - Genre: Int, Codable

enum Genre: Int, Codable {
    case pointAndClick = 2
    case fighting = 4
    case shooter
    case music = 7
    case platform
    case puzzle
    case racing
    case realTimeStrategy
    case rolePlaying
    case simulator
    case sport
    case strategy
    case turnBasedStrategy
    case tactical = 24
    case beatEmUp
    case quizTrivia
    case pinball = 30
    case adventure
    case indie
    case arcade
}
