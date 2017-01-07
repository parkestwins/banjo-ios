//
//  Platform.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

// MARK: - Platform: Object

final class Platform: Object {
    
    // MARK: Properties
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var abbreviation = ""
    let games = List<Game>()
    
    // MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
