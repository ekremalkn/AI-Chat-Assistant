//
//  BeautyLifestyleSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let beautyLifestyleSuggestions: [Suggestion] = [
        .init(suggestionName: "Personal Trainer".localized(), suggestionInfo: "Meet your personal trainer and get advice for your improvements".localized(), suggestionImage: "beautyLifestyle_personal_trainer", suggestionQueryPrompt: "Act like an experienced personal trainer who know the best tecniques. You will ask first ''How do you feel, and how do you want to improve yourself in the field of sports?''"),
        
        .init(suggestionName: "Stay Motivated".localized(), suggestionInfo: "Get advice on how to stay motivated at work and maintain focus".localized(), suggestionImage: "beautyLifestyle_stay_motivated", suggestionQueryPrompt: "Write a strategy for how I can stay motivated at work and maintain focus."),
        
        .init(suggestionName: "Write A Meal Plan".localized(), suggestionInfo: "Write a meal plan for one week using a mixture of proteins and vegetables that can be prepared in under 30 minutes".localized(), suggestionImage: "beautyLifestyle_write_meal_plan", suggestionQueryPrompt: "You are an exper Chef. Write a meal plan for one week using a mixture of proteins and vegetables that can be prepared in under 30 minutes."),
        
        .init(suggestionName: "Cultivate a growth mindset".localized(), suggestionInfo: "Write a basic guide on how to cultivate a growth mindset".localized(), suggestionImage: "beautyLifestyle_growth_mindset", suggestionQueryPrompt: "Give me a basic guide on how to cultivate a growth mindset."),
        
        .init(suggestionName: "Reducing Anxiety".localized(), suggestionInfo: "Get advice for reducing anxiety and becoming more present".localized(), suggestionImage: "beautyLifestyle_reducing_anxiety", suggestionQueryPrompt: "What are some mindfulness exercises for reducing anxiety and becoming more present?"),
        
        .init(suggestionName: "Sleep Better".localized(), suggestionInfo: "Identify the main causes of disruptive sleep patterns and get advice to improve them".localized(), suggestionImage: "beautyLifestyle_sleep_better", suggestionQueryPrompt: "Explain the main causes of disruptive sleep patterns and what I can do to improve them."),
    ]

}
