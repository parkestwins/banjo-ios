//
//  UIColor+Hex.swift
//  Banjo
//
//  Created by Arshad Chummun on 6/4/14.
//  gist.github.com/arshad/de147c42d7b3063ef7bc
//
//  Modified by Jarrod Parkes on 12/30/16.
//

import UIKit

// MARK: - UIColor (From Hex)

extension UIColor {
    
    convenience init(hex: String) {
        
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.characters.count != 6 {
            self.init(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        } else {
            var rgbHex: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbHex)
            
            self.init(red: CGFloat((rgbHex & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbHex & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbHex & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
        }        
    }
    
    class func banjoRed() -> UIColor {
        return UIColor(red: 254/255, green: 56/255, blue: 36/255, alpha: 1)
    }
}
