//
//  Game.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

// MARK: - Game: Object

final class Game: Object {
    
    // MARK: Properties
    
    dynamic var id = ""
    dynamic var title = ""
    let playersMin = RealmOptional<Int>()
    let playersMax = RealmOptional<Int>()
    let releases = List<Release>()
    let genres = List<Genre>()
    
    // MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
