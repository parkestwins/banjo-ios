//
//  DateHelper.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let dateStringFormatter = DateFormatter()
    
    class func dateFromString(_ dateString: String) -> NSDate {
        dateStringFormatter.dateFormat = "MM/dd/yy"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateStringFormatter.date(from: dateString)!
        return NSDate(timeInterval: 0, since: date)
    }
    
    class func dateToString(_ date: NSDate) -> String {
        dateStringFormatter.dateFormat = "MMMM d, yyyy"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateStringFormatter.string(from: date as Date)
    }
}
