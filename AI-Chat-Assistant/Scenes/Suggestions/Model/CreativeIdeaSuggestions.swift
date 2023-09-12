//
//  CreativeIdeaSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let creativeIdeaSuggestions: [Suggestion] = [
        .init(suggestionName: "Brainstorming", suggestionInfo: "Generate new product ideas", suggestionImage: "house", suggestionQueryPrompt: "You will do brainstorming for product. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about my product"),
        .init(suggestionName: "Creative Story", suggestionInfo: "Begin a creative writing journey", suggestionImage: "house", suggestionQueryPrompt: "You are an expert Creative Story maker. You will create creative story. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about story topic/subject."),
        .init(suggestionName: "Children Activities", suggestionInfo: "Creative children activities", suggestionImage: "house", suggestionQueryPrompt: "What are some unique ideas for activities for five-year-old child?"),
        .init(suggestionName: "Character Creation", suggestionInfo: "Create uniquie fictional characters", suggestionImage: "house", suggestionQueryPrompt: "You are an expert Character Creator. You will create a chracter. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about in 3 short questions essentials in character."),
        .init(suggestionName: "Fantasy Food", suggestionInfo: "Design fantastical food concepts", suggestionImage: "house", suggestionQueryPrompt: "Your are an fantasy food chef. You will make fantastical food concepts. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about in 3 short questions essentials in food."),
        .init(suggestionName: "Team Building", suggestionInfo: "Plan team-building activities for a team", suggestionImage: "house", suggestionQueryPrompt: "You are an expert Team Builder. You will build a team for my activity. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about my activity."),
    ]
}
