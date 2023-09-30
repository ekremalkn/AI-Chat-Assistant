//
//  SuggestionModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 3.09.2023.
//

import Foundation

struct SuggestionSection {
    var suggestionSectionCategory: SuggestionSectionCategory
    var suggestions: [SuggestionModel]
}

enum SuggestionSectionCategory {
    case mostUsedSuggestions
    case allSuggestions
}

struct SuggestionModel {
    var suggestionCategory: SuggestionCategory
    var suggestions: [Suggestion]
}

struct Suggestion {
    var suggestionName: String
    var suggestionInfo: String
    var suggestionImage: String
    var suggestionQueryPrompt: String
}

enum SuggestionCategory {
    case travel
    case creativeIdeas
    case beautyLifestyle
    case education
    case fun
    case healthNutrition
    case astrology
    case art
    case businessMarketing
    case fashion
    case socialMedia
    case career
    case email
    case mostUsed
}

extension SuggestionCategory {
    var suggestionCategoryTitle: String {
        switch self {
        case .travel:
            return "🧳 Travel & Explore".localized()
        case .creativeIdeas:
            return "💡 Creative Ideas".localized()
        case .beautyLifestyle:
            return "🌞 Beauty & Lifestyle".localized()
        case .education:
            return "🧑‍🎓 Education".localized()
        case .fun:
            return "😹 Fun".localized()
        case .healthNutrition:
            return "🥗 Health & Nutrition".localized()
        case .astrology:
            return "🔮 Astrology".localized()
        case .art:
            return "🎨 Art".localized()
        case .businessMarketing:
            return "📈 Business & Marketing".localized()
        case .fashion:
            return "👯‍♂️ Fashion".localized()
        case .career:
            return "🧑‍💼 Career".localized()
        case .email:
            return "✉️ E-Mail".localized()
        case .socialMedia:
            return "🌍 Social Media".localized()
        case .mostUsed:
            return "Most Used".localized()
        }
    }
}



