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
    
    var name: String {
        switch self {
        case .pointAndClick: return "Point-Click"
        case .fighting: return "Fighting"
        case .shooter: return "Shooter"
        case .music: return "Music"
        case .platform: return "Platform"
        case .puzzle: return "Puzzle"
        case .racing: return "Racing"
        case .realTimeStrategy: return "RTS"
        case .rolePlaying: return "Role Playing"
        case .simulator: return "Simulator"
        case .sport: return "Sports"
        case .strategy: return "Strategy"
        case .turnBasedStrategy: return "Turn-Based"
        case .tactical: return "Tactical"
        case .beatEmUp: return "Beat Em' Up"
        case .quizTrivia: return "Trivia"
        case .pinball: return "Pinball"
        case .adventure: return "Adventure"
        case .indie: return "Indie"
        case .arcade: return "Arcade"
        }
    }
}
