//
//  BusinessMarketing.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let businessMarketing: [Suggestion] = [
        .init(suggestionName: "Analyze industry", suggestionInfo: "Analyze the current state of industry and its trends, challenges, and opportunities, including relevant data and statistics.", suggestionImage: "house", suggestionQueryPrompt: "Analyze the current state of <industry> and its trends, challenges, and opportunities, including relevant data and statistics. Provide a list of key players and a short and long-term industry forecast, and explain any potential impact of current events or future developments. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Software or tool for your business", suggestionInfo: "", suggestionImage: "house", suggestionQueryPrompt: "Offer a detailed review of a <specific software or tool> for <business>. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Legislation and regulations", suggestionInfo: "", suggestionImage: "house", suggestionQueryPrompt: "Offer an in-depth analysis of the current state of [business size] business legislation and regulations and their impact on entrepreneurship. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "SEO Generator", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Slide Presentation", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Prepare a Professional Business Plan", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Social Media Caption Generator", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Post Ideas", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Email Generator", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Ad Copy Inspiration", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Research Insights", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Brand Tagline", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Product Naming", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Marketing Storyboard", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Online Strategy", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Marketing Slogans", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
        
        .init(suggestionName: "Brand Identitiy", suggestionInfo: "", suggestionImage: "", suggestionQueryPrompt: ""),
    ]
    
}
