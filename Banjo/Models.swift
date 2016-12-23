//
//  Models.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Models

final class Platform: Object {
    dynamic var title = ""
    dynamic var abbreviation = ""
    dynamic var id = ""
    let games = List<Game>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Game: Object {
    dynamic var title = ""
    dynamic var publisher = ""
}
