//
//  Release.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/4/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import RealmSwift

final class Release: Object {
    dynamic var id = ""
    dynamic var game: Game?
    dynamic var specialTitle: String? = nil
    dynamic var date = NSDate()
    dynamic var publisher = ""
    dynamic var developer = ""
    dynamic var coverImagePath: String? = nil
    dynamic var summary = ""
    dynamic var rating: Rating?
    dynamic var releaseRegion: ReleaseRegion?
    dynamic var gameplayPath: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
