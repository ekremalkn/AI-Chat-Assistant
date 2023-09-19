//
//  Date+LocalizedString.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 19.09.2023.
//

import Foundation

extension Date {
    func localizedStringWithFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
