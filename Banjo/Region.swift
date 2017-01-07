//
//  Region.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

// MARK: - Region: Object

final class Region: Object {
    
    // MARK: Properties
    
    dynamic var id = ""
    dynamic var abbreviation = ""
    dynamic var name = ""
    
    // MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
