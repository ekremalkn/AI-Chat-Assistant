//
//  TravelSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let travelSuggestions: [Suggestion] = [
        .init(suggestionName: "Create a travel playlist", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: "I’m traveling to [destination], and I want you to create a playlist that captures the mood and spirit of the [country/city]. Please suggest songs and artists popular in the local music scene that match my taste. Some of my favorite [genres/artists/songs] are [details], and the purpose of the playlist is to [get into the mood for sightseeing and exploring]. I’m also looking forward to [specific plans/activities]. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Local Foods", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: "I’m traveling to [destination], and I’m interested in discovering organic food restaurants and markets that promote sustainable agriculture. Can you suggest options that specialize in [type of organic food you’re interested in] located in [neighborhoods or areas of destination]? I have [any specific dietary restrictions or allergies]. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Help me learn a new language", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: "I’m planning a trip to [Country] and want to improve my [Language] language skills. My current language level is [beginner]. Can you provide customized language lessons and practice exercises focusing on [conversational Language and essential travel phrases]? I also plan to visit [Paris and the French countryside], so any region-specific language tips would be helpful. You first message should be to meet person and ask 3 short question what you need."),
                
        .init(suggestionName: "Budgeting Tips", suggestionInfo: "Providing tips for saving money relevant", suggestionImage: "", suggestionQueryPrompt: "I’m planning a trip to [destination] for [length of time], and I want you to create a travel budget and track my expenses. My budget for the trip is [budget]. Can you make a budget template tailored to my specific needs? Additionally, provide tips for saving money relevant to my travel style. My style is [budget/luxury/somewhere in between]. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Advise on off-season travel", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: "I’m planning a trip to [city] and want to avoid crowds. Please recommend the best time of year to visit my destination and suggest off-season attractions and activities. I’m particularly interested in [interests] and prefer [weather preferences]. The trip will last [number] days. You first message should be to meet person and ask 3 short question what you need."),

    ]
}
