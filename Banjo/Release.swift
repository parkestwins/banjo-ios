//
//  Release.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

// MARK: - Release: Object

final class Release: Object {
    
    // MARK: Properties
    
    dynamic var id = ""
    dynamic var game: Game?
    dynamic var specialTitle: String? = nil
    dynamic var date: NSDate? = nil
    dynamic var publisher = ""
    dynamic var developer = ""
    dynamic var coverImagePath: String? = nil
    dynamic var summary = ""
    dynamic var rating: Rating?
    dynamic var region: Region?
    dynamic var gameplayPath: String? = nil
    
    // MARK: Primary Key
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
