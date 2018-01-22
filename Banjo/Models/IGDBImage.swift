//
//  IGDBImage.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - IGDBImage: Codable

struct IGDBImage: Codable {
    let url: String
    let cloudinaryID: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case url
        case cloudinaryID = "cloudinary_id"
        case width
        case height
    }
}
