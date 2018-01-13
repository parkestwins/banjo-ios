//
//  PEGI.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - PEGI: Codable

struct PEGI: Codable {
    let synopsis: String
    let rating: PEGIRating
    
    enum CodingKeys: String, CodingKey {
        case synopsis
        case rating
    }
}
