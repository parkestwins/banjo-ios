//
//  RatingSystem.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

final class RatingSystem: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var abbreviation: String? = nil
    dynamic var website: String? = nil
    let ratings = List<Rating>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
