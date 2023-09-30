//
//  LanguageManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 30.09.2023.
//

import Foundation

final class LanguageManager {
    

    //MARK: - Init Methods
    private init() { }
    
    static func getCurrentLanugageCode() -> String {
        if #available(iOS 16, *) {
            return Locale.current.language.languageCode?.identifier ?? "english"
        } else {
            return Locale.current.languageCode ?? "english"
        }
    }
    
    static func getSuggestionEndPointPromptForCurrentLanguage() -> String {
        return "Can you provide your answer in \(getCurrentLanugageCode()) language?"
    }
}
