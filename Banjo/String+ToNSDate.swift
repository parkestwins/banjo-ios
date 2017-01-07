//
//  String+ToNSDate.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/30/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - String (To Date)

extension String {
    
    func toNSDate() -> NSDate? {
        let formatter = DateHelper.formatter
        formatter.dateFormat = "MM/dd/yy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = formatter.date(from: self) {
            return NSDate(timeInterval: 0, since: date)
        } else {
            return nil
        }
    }
}
