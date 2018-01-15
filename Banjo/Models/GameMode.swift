//
//  GameMode.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation
import UIKit

// MARK: - GameMode: Int, Codable

enum GameMode: Int, Codable {
    case single = 1
    case multi
    case coop
    case splitScreen
    case mmo
    
    var image: UIImage {
        switch self {
        case .single: return #imageLiteral(resourceName: "single")
        case .multi: return #imageLiteral(resourceName: "multi")
        case .coop: return #imageLiteral(resourceName: "coop")
        case .splitScreen: return #imageLiteral(resourceName: "splitscreen")
        case .mmo: return #imageLiteral(resourceName: "mmo")
        }
    }
}
