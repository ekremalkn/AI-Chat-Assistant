//
//  LanguageManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 30.09.2023.
//

import Foundation
import SwiftyTranslate

final class LanguageManager {
    

    //MARK: - Init Methods
    private init() { }
    
    static func getCurrentLanugageCode() -> String {
        if #available(iOS 16, *) {
            return Locale.current.language.languageCode?.identifier ?? "en"
        } else {
            return Locale.current.languageCode ?? "en"
        }
    }
    
    static func getSuggestionEndPointPromptForCurrentLanguage() -> String {
        return "Can you provide your answer in \(getCurrentLanugageCode()) language?"
    }
    
    static func translate(text: String, completion: @escaping (_ translatedText: String) -> Void) {
        SwiftyTranslate.translate(text: text, from: "en", to: getCurrentLanugageCode()) { result in
            switch result {
            case .success(let translation):
                completion(translation.translated.localizedCapitalized)
            case .failure(_):
                completion(text)
            }
        }
    }
}
