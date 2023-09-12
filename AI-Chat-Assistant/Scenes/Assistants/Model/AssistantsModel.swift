//
//  AssistantsModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import Foundation


struct AssistantsModel {
    var assistantCateogry: AssistantCategory
}


enum AssistantCategory: CaseIterable {
    case business
    case writing
    case languageTools
}

extension AssistantCategory {
    var sectionTitle: String {
        switch self {
        case .business:
            return "📈 Business"
        case .writing:
            return "✍️ Writing"
        case .languageTools:
            return "🌍 Language Tools"
        }
    }
    
    
}
