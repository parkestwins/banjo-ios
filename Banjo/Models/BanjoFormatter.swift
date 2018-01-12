//
//  BanjoFormatter.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

// FIXME: make into an extension

import Foundation

// MARK: - BanjoFormatter

struct BanjoFormatter {
    
    // MARK: Properties
    
    let dateFormatter: DateFormatter
    
    // MARK: Formatting
    
    func formatDateFromTimeIntervalSince1970(value: Int) -> String {
        let milliToSeconds = Double(value) / 1000
        return dateFormatter.string(from: Date(timeIntervalSince1970: milliToSeconds))
    }
    
    // MARK: Shared Instance
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "MMMM dd, yyyy"
    }
    
    static let shared = BanjoFormatter()
}

