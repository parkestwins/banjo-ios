//
//  ReleaseRegion.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

final class ReleaseRegion: Object {
    dynamic var id = ""
    dynamic var abbreviation = ""
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
