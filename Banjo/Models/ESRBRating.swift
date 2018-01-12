//
//  ESRBRating.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - ESRBRating: Int, Codable

enum ESRBRating: Int, Codable {
    case ratingPending = 1
    case earlyChildhood
    case everyone
    case everyone10Plus
    case teen
    case mature
    case adultOnly
    
    var name: String {
        switch self {
        case .ratingPending: return "Rating Pending"
        case .earlyChildhood: return "Early Childhood"
        case .everyone: return "Everyone"
        case .everyone10Plus: return "Everyone 10+"
        case .teen: return "Teen"
        case .mature: return "Mature"
        case .adultOnly: return "Adult Only"
        }
    }
}
