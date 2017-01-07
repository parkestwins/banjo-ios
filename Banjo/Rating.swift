//
//  Rating.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

// MARK: - Rating: Object

final class Rating: Object {
    
    // MARK: Properties
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var abbreviation = ""
    dynamic var summary = ""
    dynamic var system: RatingSystem?
    
    // MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
