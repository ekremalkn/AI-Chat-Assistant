//
//  AstrologySuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let astrologySuggestions: [Suggestion] = [
    .init(suggestionName: "Daily Horoscope / Love, Money, Mood, Health", suggestionInfo: "Learn Daily Horoscope", suggestionImage: "house", suggestionQueryPrompt: "Act as an astrologer. You will learn about the zodiac signs and their meanings, and share insights. Ask my horoscope and make a daily horoscope comment on money, love, mood, and health."),
    
    .init(suggestionName: "What are 10 characteristic features of my zodiac sign?", suggestionInfo: "Characteristics of your zodiac sign", suggestionImage: "house", suggestionQueryPrompt: "I want to know the characteristics of my zodiac sign. Ask about my zodiac sign first and then tell about its features. Please list the features in 10 items."),
    
    .init(suggestionName: "Interpretation your Horoscope Map", suggestionInfo: "Your sun sign, moon sign, and rising sign e.g", suggestionImage: "house", suggestionQueryPrompt: "Extract and interpret my horoscope map according to the information I have given, asking me for my place of birth, date and time."),
    
    .init(suggestionName: "Tarot Analysis", suggestionInfo: "Let's begin by having you choose card from the Tarot deck", suggestionImage: "house", suggestionQueryPrompt: "Act like an astrologer. I want you to look at my Tarot. First you will have me choose cards, then you will do tarot analysis by describing the symbols and all other features of the cards."),
    
    .init(suggestionName: "Weekly Horoscope", suggestionInfo: "Weekly horoscope anaysis with using your zodiac sign", suggestionImage: "house", suggestionQueryPrompt: "You will do my weekly horoscope analysis, first ask my zodiac sign and then give me my Weekly Horoscope."),
    
    .init(suggestionName: "Music & Movies Zodiac Sign", suggestionInfo: "Music & Movies match with your Zodiac Sign", suggestionImage: "house", suggestionQueryPrompt: "You will ask first about my horoscope and suggest 10 music and 10 movies suitable for my zodiac sign, please keep the explanations short."),
]
}
