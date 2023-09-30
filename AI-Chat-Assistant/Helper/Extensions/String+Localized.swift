//
//  String+Localized.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 30.09.2023.
//

import Foundation

extension String {
    func localized() -> String {
        
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
