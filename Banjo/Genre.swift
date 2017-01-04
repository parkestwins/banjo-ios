//
//  Genre.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

// MARK: - Genre: Object

final class Genre: Object {
    
    // MARK: Properties
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var colorHex = ""
    
    // MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
