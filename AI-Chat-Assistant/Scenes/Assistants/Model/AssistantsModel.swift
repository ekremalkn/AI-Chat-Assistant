//
//  AssistantsModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import Foundation


struct AssistantsModel {
    var assistantCategory: AssistantCategory
    var assistants: [Assistant]
}

struct Assistant {
    var assistantTitle: String
    var assistantPrompt: String
}

enum AssistantCategory {
    case sales
    case seo
    case general
    case writing
    case marketing
    case socialMedia
    case coding
    case design
    case language
    case music
    case teaching
    case research
    case speech
    case business
    case dataAnalysis
    case email
    case job
    case reading
    case paidAds
    case finance
    case health
    case fun
    case it
}

extension AssistantCategory {
    var assistantCategoryTitle: String {
        switch self {
        case .sales:
            return "Sales"
        case .seo:
            return "SEO"
        case .general:
            return "General"
        case .writing:
            return "Writing"
        case .marketing:
            return "Marketing"
        case .socialMedia:
            return "Social Media"
        case .coding:
            return "Coding"
        case .design:
            return "Design"
        case .language:
            return "Language"
        case .music:
            return "Music"
        case .teaching:
            return "Teaching"
        case .research:
            return "Research"
        case .speech:
            return "Speech"
        case .business:
            return "Business"
        case .dataAnalysis:
            return "Data Analysis"
        case .email:
            return "Email"
        case .job:
            return "Job"
        case .reading:
            return "Reading"
        case .paidAds:
            return "Paid Ads"
        case .finance:
            return "Finance"
        case .health:
            return "Health"
        case .fun:
            return "Fun"
        case .it:
            return "IT"
        }
    }


}
