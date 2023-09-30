//
//  SocialSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let fashionSuggestions: [Suggestion] = [
        .init(suggestionName: "Brand Tagline".localized(), suggestionInfo: "Create a catchy brand tagline".localized(), suggestionImage: "businessMarketing_brand_tagline", suggestionQueryPrompt: "Create a catchy and memorable tagline that highlights the unique selling proposition of {product/service}. The inital questions you will ask what is product/service."),
                
        .init(suggestionName: "Picnic Outfit Idea".localized(), suggestionInfo: "Get ideas for a casual outdoor picnic".localized(), suggestionImage: "fashion_picnic_outfit", suggestionQueryPrompt: "I’m planning a casual outdoor picnic. Could you help me choose an outfit that’s both comfortable and stylish? I want something that works well for a relaxed setting but still looks put together"),
        
            .init(suggestionName: "Product Naming".localized(), suggestionInfo: "Generate product naming ideas".localized(), suggestionImage: "businessMarketing_product_naming", suggestionQueryPrompt: "I need a catchy name for my [Product]. The inital questions you will ask what is ''What is product / What kind of product'' "),
        
        .init(suggestionName: "Long Flight Outfit Idea".localized(), suggestionInfo: "Get to know what's a long flight outfit".localized(), suggestionImage: "fashion_long_flight_outfit", suggestionQueryPrompt: "I have a long flight coming up, and I want to be both comfortable and stylish. What’s a travel outfit that strikes a balance between coziness and a trendy look?"),
        
        .init(suggestionName: "Winter Fashion Choices".localized(), suggestionInfo: "Update your fashion choices for winter".localized(), suggestionImage: "fashion_winter_fashion", suggestionQueryPrompt: "With winter approaching, I’m looking to update my fashion choices. Can you recommend colors and styles that work well for this season while keeping me fashion-forward?"),
        
    ]
    
}
