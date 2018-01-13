//
//  AlternativeName.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - AlternativeName: Codable

struct AlternativeName: Codable {
    let name: String
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case comment
    }
}
