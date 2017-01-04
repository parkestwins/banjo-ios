//
//  Rating.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

final class Rating: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var abbreviation = ""
    dynamic var summary = ""
    dynamic var system: RatingSystem?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
