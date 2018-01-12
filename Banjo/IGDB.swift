//
//  IGDB.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/8/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - Region: Int, Codable

enum Region: Int, Codable {
    case europe = 1
    case northAmerica
    case australia
    case newZealand
    case japan
    case china
    case asia
    case worldWide
}

// MARK: - PlayerPerspective: Int, Codable

enum PlayerPerspective: Int, Codable {
    case firstPerson = 1
    case thirdPerson
    case birdView
    case sideView
    case text
    case aural
    case virtualReality
}

// MARK: - GameMode: Int, Codable

enum GameMode: Int, Codable {
    case single = 1
    case multi
    case coop
    case splitScreen
    case mmo
}

// MARK: - ESRBRating: Int, Codable

enum ESRBRating: Int, Codable {
    case ratingPending = 1
    case earlyChildhood
    case everyone
    case everyone10Plus
    case teen
    case mature
    case adultOnly
}

// MARK: - PEGIRating: Int, Codable

enum PEGIRating: Int, Codable {
    case three = 1
    case seven
    case twelve
    case sixteen
    case eighteen
}

// MARK: - GameCategory: Int, Codable

enum GameCategory: Int, Codable {
    case mainGame
    case dlcAddOn
    case expansion
    case bundle
    case standaloneExpansion
}

// MARK: - Genre: Int, Codable

enum Genre: Int, Codable {
    case pointAndClick = 2
    case fighting = 4
    case shooter
    case music = 7
    case platform
    case puzzle
    case racing
    case realTimeStrategy
    case rolePlaying
    case simulator
    case sport
    case strategy
    case turnBasedStrategy
    case tactical = 24
    case beatEmUp
    case quizTrivia
    case pinball = 30
    case adventure
    case indie
    case arcade
}

// MARK: - Theme: Int, Codable

enum Theme: Int, Codable {
    case action = 1
    case fantasy = 17
    case scienceFiction
    case horror
    case thriller
    case survival
    case historical
    case stealth
    case comedy = 27
    case business
    case drama = 31
    case nonFiction
    case sandbox
    case educational
    case kids
    case openWorld = 38
    case warfare
    case party
    case fourX // explore, expand, exploit, and exterminate
    case erotic
    case mystery
}

// MARK: - Platform: Int, Codable

enum Platform: Int, Codable {
    case linux = 3
    case n64
    case wii
    case pc
    case ps1
    case ps2
    case ps3
    case xbox = 11
    case xbox360
    case dos
    case mac
    case c64
    case amiga
    case nes = 18
    case snes
    case ds
    case gc
    case gbc
    case dc
    case gba
    case amstradCPC
    case zxSpectrum
    case msx
    case megaDrive = 29
    case sega32x
    case segaSaturn = 32
    case gameBoy
    case android
    case segaGameGear
    case xboxLiveArcade
    case nintendo3ds
    case playstationPortable
    case ios
    case wiiU = 41
    case nGage
    case tapwaveZodiac = 44
    case playstationNetwork
    case playstationVita
    case virtualConsoleNintendo
    case playstation4
    case xboxOne
    case threeDO
    case familyComputerDiskSystem
    case arcade
    case msx2
    case mobile = 55
    case wiiWare
    case wonderSwan
    case superFamicom
    case atari2600
    case atari7800
    case atariLynx
    case atariJaguar
    case atariSTSTE
    case segaMasterSystem
    case atari8Bit
    case atari5200
    case intellivision
    case colecoVision
    case bbcMicrocomputerSystem
    case vectrex
    case commodoreVIC20
    case ouya
    case blackberryOS
    case windowsPhone
    case appleII
    case sharpX1 = 77
    case segaCD
    case neoGeoMVS
    case neoGeoAES
    case webBrowser = 82
    case sg1000 = 84
    case donnerModel30
    case turboGrafx16PCEngine
    case virtualBoy
    case odyssey
    case microvision
    case commodorePET
    case ballyAstrocade
    case steamOS
    case commodore16
    case commodorePlus4
    case pdp1
    case pdp10
    case pdp8
    case decGT40
    case famicom
    case analogueElectronics
    case ferrantiNimrodComputer
    case edsac
    case pdp7
    case hp2100
    case hp3000
    case sdsSigma7
    case callAComputer
    case pdp11
    case cdcCyber70
    case plato
    case imlacPDS1
    case microcomputer
    case onLiveGameSystem
    case amigaCD32
    case appleIIGS
    case acornArchimedes
    case philipsCDI
    case fmTowns
    case neoGeoPocket
    case neoGeoPocketColor
    case sharpX68000
    case nuon
    case wonderSwanColor
    case swanCrystal
    case pc8801
    case trs80
    case fairchildChannelF
    case pcEngineSuperGrafx
    case texasInstrumentsTI99
    case nintendoSwitch
    case nintendoPlayStation
    case amazonFireTV
    case philipsVideopacG7000
    case acornElectron
    case hyperNeoGeo64
    case neoGeoCD
    case newNintendo3DS
    case vc4000
    case advancedProgrammableVideoSystem
    case ay38500
    case ay38610
    case pc50xFamily
    case ay38760
    case ay38710
    case ay38603
    case ay38605
    case ay38606
    case ay38607
    case pc98
    case turboGrafxPCEngineCD
    case trs80ColorComputer
    case fm7
    case dragon3264
    case amstradPCW
    case tatungEinstein
    case thomsonM05
    case necPC6000Series
    case commodoreCDTV
}

// MARK: - Developer: Codable

struct Developer: Codable {
    let id: Int
    let name: String?
}

struct Publisher: Codable {
    let id: Int
    let name: String?
}

// MARK: - Game: Codable

struct Game: Codable {
    let id: Int
    let name: String
    let summary: String
    let category: GameCategory
    let playerPerspectives: [PlayerPerspective]
    let gameModes: [GameMode]
    let developers: [Developer]
    let publishers: [Publisher]
    let genres: [Genre]
    let themes: [Theme]
    let firstReleaseDate: Int
    let releaseDates: [ReleaseDate]
    let screenshots: [Cover]
    let cover: Cover
    let esrb: ESRB
    let pegi: PEGI
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case summary
        case category
        case playerPerspectives = "player_perspectives"
        case gameModes = "game_modes"
        case developers
        case publishers
        case themes
        case genres
        case firstReleaseDate = "first_release_date"
        case releaseDates = "release_dates"
        case screenshots
        case cover
        case esrb
        case pegi
    }
}

// MARK: - GamePartial: Codable

struct GamePartial: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

// MARK: - GameRaw: Codable

struct GameRaw: Codable {
    let id: Int
    let name: String
    let slug: String
    let url: String
    let createdAt: Int
    let updatedAt: Int
    let summary: String
    let collection: Int
    let franchise: Int
    let franchises: [Int]
    let hypes: Int
    let rating: Double
    let popularity: Int
    let aggregatedRating: Int
    let aggregatedRatingCount: Int
    let totalRating: Double
    let totalRatingCount: Int
    let ratingCount: Int
    let games: [Int]
    let tags: [Int]
    let developers: [Int]
    let publishers: [Int]
    let category: GameCategory
    let timeToBeat: TimeToBeat
    let playerPerspectives: [PlayerPerspective]
    let gameModes: [GameMode]
    let keywords: [Int]
    let themes: [Theme]
    let genres: [Genre]
    let firstReleaseDate: Int
    let pulseCount: Int
    let platforms: [Platform]
    let releaseDates: [ReleaseDate]
    let alternativeNames: [AlternativeName]
    let screenshots: [Cover]
    let cover: Cover
    let esrb: ESRB
    let pegi: PEGI
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case summary
        case collection
        case franchise
        case franchises
        case hypes
        case rating
        case popularity
        case aggregatedRating = "aggregated_rating"
        case aggregatedRatingCount = "aggregated_rating_count"
        case totalRating = "total_rating"
        case totalRatingCount = "total_rating_count"
        case ratingCount = "rating_count"
        case games
        case tags
        case developers
        case publishers
        case category
        case timeToBeat = "time_to_beat"
        case playerPerspectives = "player_perspectives"
        case gameModes = "game_modes"
        case keywords
        case themes
        case genres
        case firstReleaseDate = "first_release_date"
        case pulseCount = "pulse_count"
        case platforms
        case releaseDates = "release_dates"
        case alternativeNames = "alternative_names"
        case screenshots
        case cover
        case esrb
        case pegi
    }
}

// MARK: - AlternativeName: Codable

struct AlternativeName: Codable {
    let name: String
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case comment
    }
}

// MARK: - Cover: Codable

struct Cover: Codable {
    let url: String
    let cloudinaryID: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case url
        case cloudinaryID = "cloudinary_id"
        case width
        case height
    }
}

// MARK: - ESRB: Codable

struct ESRB: Codable {
    let rating: ESRBRating
    
    enum CodingKeys: String, CodingKey {
        case rating
    }
}

// MARK: - PEGI: Codable

struct PEGI: Codable {
    let synopsis: String
    let rating: PEGIRating
    
    enum CodingKeys: String, CodingKey {
        case synopsis
        case rating
    }
}

// MARK: - ReleaseDate: Codable

struct ReleaseDate: Codable {
    let category: GameCategory
    let platform: Platform
    let date: Int
    let region: Region
    let human: String
    let year: Int
    let month: Int
    
    enum CodingKeys: String, CodingKey {
        case category
        case platform
        case date
        case region
        case human
        case year = "y"
        case month = "m"
    }
}

// MARK: - TimeToBeat: Codable

struct TimeToBeat: Codable {
    let hastly: Int
    let normally: Int
    let completely: Int
    
    enum CodingKeys: String, CodingKey {
        case hastly
        case normally
        case completely
    }
}
