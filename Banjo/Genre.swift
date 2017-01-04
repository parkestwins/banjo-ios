//
//  Genre.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

final class Genre: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var colorHex = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
