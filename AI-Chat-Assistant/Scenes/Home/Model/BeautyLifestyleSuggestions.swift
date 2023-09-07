//
//  BeautyLifestyleSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let beautyLifestyleSuggestions: [Suggestion] = [
        .init(suggestionName: "Personal Trainer", suggestionInfo: "Meet your personal trainer and get advice for your improvements", suggestionImage: "house", suggestionQueryPrompt: "Act like an experienced personal trainer who know the best tecniques. You will ask first ''How do you feel, and how do you want to improve yourself in the field of sports?''"),
        
        .init(suggestionName: "Stay Motivated", suggestionInfo: "Get advice how can stay motivated at work and maintain focus", suggestionImage: "house", suggestionQueryPrompt: "Write a strategy for how I can stay motivated at work and maintain focus."),
        
        .init(suggestionName: "Write A Meal Plan", suggestionInfo: "Write a meal plan for one week using a mixture of proteins and vegetables that can be prepared in under 30 minutes", suggestionImage: "house", suggestionQueryPrompt: "You are an exper Chef. Write a meal plan for one week using a mixture of proteins and vegetables that can be prepared in under 30 minutes."),
        
        .init(suggestionName: "Cultivate a growth mindset", suggestionInfo: "Write a basic guide on how to cultivate a growth mindset", suggestionImage: "house", suggestionQueryPrompt: "Give me a basic guide on how to cultivate a growth mindset."),
        
        .init(suggestionName: "Reducing Anxiety", suggestionInfo: "Get advice for reduicing anxiety and becoming more present", suggestionImage: "house", suggestionQueryPrompt: "What are some mindfulness exercises for reducing anxiety and becoming more present?"),
        
        .init(suggestionName: "Sleep Better", suggestionInfo: "Main causes of disruptive sleep patterns and get advice to improve them", suggestionImage: "house", suggestionQueryPrompt: "Explain the main causes of disruptive sleep patterns and what I can do to improve them."),
    ]

}
