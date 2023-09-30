//
//  StrikethroughLabel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 29.09.2023.
//

import UIKit

class StrikethroughLabel: UILabel {
    
    var strikeThroughText: String? {
        didSet {
            if let strikeThroughText = strikeThroughText {
                let attributedString = NSMutableAttributedString(string: strikeThroughText)
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
                attributedText = attributedString
            } else {
                attributedText = nil
            }
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

