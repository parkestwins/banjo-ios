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
}
