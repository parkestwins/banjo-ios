//
//  TimeToBeat.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - TimeToBeat: Codable

struct TimeToBeat: Codable {
    let hastly: Int
    let normally: Int
    let completely: Int
    
    enum CodingKeys: String, CodingKey {
        case hastly
        case normally
        case completely
    }
}
