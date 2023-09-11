//
//  SocialSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let fashionSuggestions: [Suggestion] = [
        .init(suggestionName: "Picnic Outfit Idea", suggestionInfo: "Get ideas for a casual outdoor picnic", suggestionImage: "house", suggestionQueryPrompt: "I’m planning a casual outdoor picnic. Could you help me choose an outfit that’s both comfortable and stylish? I want something that works well for a relaxed setting but still looks put together"),
        
        .init(suggestionName: "Long Flight Outfit Idea", suggestionInfo: "Get know what's a long flight outfit. ", suggestionImage: "house", suggestionQueryPrompt: "I have a long flight coming up, and I want to be both comfortable and stylish. What’s a travel outfit that strikes a balance between coziness and a trendy look?"),
        
        .init(suggestionName: "Winter Fashion Choices", suggestionInfo: "Update you fashion choices for winter", suggestionImage: "house", suggestionQueryPrompt: "With winter approaching, I’m looking to update my fashion choices. Can you recommend colors and styles that work well for this season while keeping me fashion-forward?"),
        
    ]
    
}
