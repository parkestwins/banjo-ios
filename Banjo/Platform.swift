//
//  Platform.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

final class Platform: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var abbreviation = ""
    let games = List<Game>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
