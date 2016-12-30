//
//  Models.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
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
    let releases = List<Release>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Rating: Object {
    dynamic var id = ""
    dynamic var abbreviation = ""
    dynamic var shortDescription = ""
    dynamic var longDescription = ""
    
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
    dynamic var coverImagePath = ""
    dynamic var summary = ""
    dynamic var rating: Rating?
    dynamic var releaseRegion: ReleaseRegion?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class ReleaseRegion: Object {
    dynamic var id = ""
    dynamic var abbreviation = ""
    let geoRegions = List<GeoRegion>()
    let countries = List<Country>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class GeoRegion: Object {
    dynamic var id = ""
    dynamic var abbreviation = ""
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Country: Object {
    dynamic var id = ""
    dynamic var abbreviation = ""
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
