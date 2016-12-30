//
//  NSDate+toString.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import Foundation

class DateHelper {
    static let formatter = DateFormatter()
}

extension NSDate {
    
    func toString() -> String {
        let formatter = DateHelper.formatter
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self as Date)
    }
}
