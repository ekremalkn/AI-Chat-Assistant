//
//  BusinessMarketingSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let businessMarketing: [Suggestion] = [
        .init(suggestionName: "Social Media Caption Generator".localized(), suggestionInfo: "Generate social media captions based on concept, type, and platform".localized(), suggestionImage: "businessMarketing_caption_generator", suggestionQueryPrompt: "Act as a Social Media Caption Inspiration Generator. After receiving the answers to your questions, you will generate 10 Social Media Captions. The initial questions you will ask are as follows: Caption Concept, Caption Type, the platform where it will be published, and whether there will be an Emoji."),
        
        .init(suggestionName: "Post Ideas".localized(), suggestionInfo: "Generate engaging social media post ideas".localized(), suggestionImage: "businessMarketing_post_ideas", suggestionQueryPrompt: "Generate an engaging social media post about [topic] that encourages user interaction. The inital questions you will ask what is topic about social media post idea."),
        
        .init(suggestionName: "Generate Business Ideas".localized(), suggestionInfo: "Generate innovative business ideas in your industry".localized(), suggestionImage: "businessMarketing_business_ideas", suggestionQueryPrompt: "Generate a list of 10 innovative business ideas in the [industry] sector. You first message should be to meet person and ask 3 short question what you need."),
                        
        .init(suggestionName: "Brand Tagline".localized(), suggestionInfo: "Create a catchy brand tagline".localized(), suggestionImage: "businessMarketing_brand_tagline", suggestionQueryPrompt: "Create a catchy and memorable tagline that highlights the unique selling proposition of {product/service}. The inital questions you will ask what is product/service."),
                
        .init(suggestionName: "Product Naming".localized(), suggestionInfo: "Generate product naming ideas".localized(), suggestionImage: "businessMarketing_product_naming", suggestionQueryPrompt: "I need a catchy name for my [Product]. The inital questions you will ask what is ''What is product / What kind of product'' "),
                
        .init(suggestionName: "Online Strategy".localized(), suggestionInfo: "Prepare a social media plan for product launch".localized(), suggestionImage: "businessMarketing_online_strategy", suggestionQueryPrompt: "You are an expert Social Media Planner for Product Launchs. You will make plan for that [product] keep it simple, clearly and short. The inital question you will ask what is product."),
        
        .init(suggestionName: "Marketing Slogans".localized(), suggestionInfo: "Brainstorm marketing slogans".localized(), suggestionImage: "businessMarketing_marketing_slogans", suggestionQueryPrompt: "Write a slogan/tagline for {product} highlighting its features and benefits. Make it compelling and memorable. Use persuasive language and strong call-to-action. Capture the essence of {brand} and resonate with {target audience}. The inital questions you will ask what is product, brand, target audience."),
                
        .init(suggestionName: "Niche Markets".localized(), suggestionInfo: "Get to know three niche markets in your industry".localized(), suggestionImage: "businessMarketing_nicke_markets", suggestionQueryPrompt: "Suggest three niche markets within the [industry] that have growth potential. You first message should be to meet person and ask 3 short question what you need."),
        
    ]
    
}
