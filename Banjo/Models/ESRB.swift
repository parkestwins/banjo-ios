//
//  ESRB.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - ESRB: Codable

struct ESRB: Codable {
    let rating: ESRBRating
    
    enum CodingKeys: String, CodingKey {
        case rating
    }
}
