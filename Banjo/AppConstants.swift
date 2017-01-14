//
//  AppConstants.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/13/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

// MARK: - AppConstants

struct AppConstants {
    
    // MARK: Settings
    
    struct Settings {
        static let dateOutputFormat = "MMMM d, yyyy"
        static let dateInputFormat = ""
        static let dateLocale = "en_US_POSIX"
    }
    
    // MARK: Nibs
    
    struct Nibs {
        static let genreCell = "GenreCell"
        static let gameCell = "GameCell"
        static let releaseCell = "ReleaseCell"
    }
    
    // MARK: Segues
    
    struct Segues {
        static let showRelease = "showRelease"
        static let showDetail = "showDetail"
        static let saveRelease = "saveRelease"
        static let login = "login"
    }
    
    // MARK: IDs
    
    struct IDs {
        static let genreCell = "genreCell"
        static let gameCell = "gameCell"
        static let releaseCell = "releaseCell"
    }
    
    // MARK: Strings
    
    struct Strings {
        static let dismiss = "Dismiss"
        static let unreleased = "Unreleased"
        static let rating = "Rating"
        static let searchTitle = "N64 Games"
        static let selectReleaseTitle = "Select Release"
        
        static let startInitDatabase = "Initializing Database..."
        static let startErrorInit = "Error Initializing..."
        static let startSearchDatabase = "Search N64 Database..."
        
        static let failSync = "Database Initialization Failed."
        static let failAuth = "Authorization Failed."
        
        static let resolveSync = "To resolve, please connect to a network. Once connected, the database initialization will restart momentarily."
        static let resolveAuthError = "There were issues authorizing this app instance. To resolve, try uninstalling and reinstalling the app."
    }
}
