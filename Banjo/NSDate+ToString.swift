//
//  NSDate+toString.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - DateHelper

class DateHelper {
    static let formatter = DateFormatter()
}

// MARK: - NSDate (To String)

extension NSDate {
    
    func toString() -> String {
        let formatter = DateHelper.formatter
        formatter.dateFormat = AppConstants.Settings.dateOutputFormat
        formatter.locale = Locale(identifier: AppConstants.Settings.dateLocale)
        return formatter.string(from: self as Date)
    }
}
