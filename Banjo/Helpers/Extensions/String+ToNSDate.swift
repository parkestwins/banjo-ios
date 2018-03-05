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
        formatter.dateFormat = AppConstants.Settings.dateInputFormat
        formatter.locale = Locale(identifier: AppConstants.Settings.dateLocale)
        if let date = formatter.date(from: self) {
            return NSDate(timeInterval: 0, since: date)
        } else {
            return nil
        }
    }
}
