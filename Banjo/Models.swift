//
//  Models.swift
//  BanjoWriter
//
//  Created by Jarrod Parkes on 1/2/17.
//  Copyright © 2017 Parkes Twins. All rights reserved.
//

import Foundation
import RealmSwift

// FIXME: add indexed properties for faster lookup/querying

// MARK: Models

final class Platform: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var abbreviation = ""
    let games = List<Game>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Game: Object {
    dynamic var id = ""
    dynamic var title = ""
    let playersMin = RealmOptional<Int>()
    let playersMax = RealmOptional<Int>()
    let releases = List<Release>()
    let genres = List<Genre>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Genre: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var colorHex = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class RatingSystem: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var abbreviation: String? = nil
    dynamic var website: String? = nil
    let ratings = List<Rating>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Rating: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var abbreviation = ""
    dynamic var summary = ""
    dynamic var system: RatingSystem?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

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

final class ReleaseRegion: Object {
    dynamic var id = ""
    dynamic var abbreviation = ""
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
