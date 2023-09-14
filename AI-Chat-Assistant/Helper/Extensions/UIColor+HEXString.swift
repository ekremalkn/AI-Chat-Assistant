//
//  UIColor+HEXString.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 14.09.2023.
//

import UIKit.UIColor

extension UIColor {
    convenience init(hex: String) {
        var characterString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if characterString.hasPrefix("#") {
            characterString.remove(at: characterString.startIndex)
        }
        
        if characterString.count != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: characterString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1)
    }
}
