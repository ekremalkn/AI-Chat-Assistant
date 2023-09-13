//
//  SuggestionModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 3.09.2023.
//

import Foundation

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
}

extension SuggestionCategory {
    var suggestionCategoryTitle: String {
        switch self {
        case .travel:
            return "🧳 Travel & Explore"
        case .creativeIdeas:
            return "💡 Creative Ideas"
        case .beautyLifestyle:
            return "🌞 Beauty & Lifestyle"
        case .education:
            return "🧑‍🎓 Education"
        case .fun:
            return "😹 Fun"
        case .healthNutrition:
            return "🥗 Health & Nutrition"
        case .astrology:
            return "🔮 Astrology"
        case .art:
            return "🎨 Art"
        case .businessMarketing:
            return "📈 Business & Marketing"
        case .fashion:
            return "👯‍♂️ Fashion"
        case .career:
            return "🧑‍💼 Career"
        case .email:
            return "✉️ E-Mail"
        case .socialMedia:
            return "🌍 Social Media"
        }
    }
}



