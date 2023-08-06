//
//  ColorSet.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit.UIColor

extension UIColor {
    static var vcBackground: UIColor {
        return .init(named: "VCBackground") ?? .systemBackground
    }
    
    static var cellBackground: UIColor {
        return .init(named: "CellBackground") ?? .secondarySystemBackground
    }
    
    static var buttonBackground: UIColor {
        return .init(named: "ButtonBackground") ?? .tertiarySystemBackground
    }
    
    static var textViewBackground: UIColor {
        return .init(named: "TextViewBackground") ?? .tertiarySystemGroupedBackground
    }
}
