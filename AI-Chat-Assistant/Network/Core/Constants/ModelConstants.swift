//
//  ModelConstants.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import Foundation

enum GPTModel {
    case gpt3_5Turbo
    case gpt4
}

extension GPTModel {
    var modelRequestName: String {
        switch self {
        case .gpt3_5Turbo:
            return "gpt-3.5-turbo"
        case .gpt4:
            return ""
        }
    }
    
    var modelUIImage: String {
        switch self {
        case .gpt3_5Turbo:
            return "ChatGPT"
        case .gpt4:
            return "ChatGPT"
        }
    }
    
    var modelUIName: String {
        switch self {
        case .gpt3_5Turbo:
            return "GPT-3.5"
        case .gpt4:
            return "GPT-4"
        }
    }
    
    
    
    var modelUIInfo: String {
        switch self {
        case .gpt3_5Turbo:
            return "Default chatbot model provided by OpenAI"
        case .gpt4:
            return "Most advanced system, producing safe and more useful responses"
        }
    }
    
    var modelUIMoreInfo: String {
        switch self {
        case .gpt3_5Turbo:
            return "ChatGPT-3.5 Turbo, despite being a smaller model, has an advantage in providing faster responses. It can be preferred by users who want to obtain faster results."
        case .gpt4:
            return "ChatGPT-4, while having more advanced capabilities, may run a bit slower than GPT-3.5 Turbo due to being a larger model. This could mean a delay in processing requests."
        }
    }
}