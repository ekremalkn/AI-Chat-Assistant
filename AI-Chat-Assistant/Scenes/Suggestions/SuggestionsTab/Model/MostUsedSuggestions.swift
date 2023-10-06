//
//  MostUsedSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let mostUsedSuggestions: [Suggestion] = [
        .init(suggestionName: "Improve your Content".localized(), suggestionInfo: "Use \(AppInfo.name) to act as your editor to improve any content you need help with".localized(), suggestionImage: "suggestion_education_improve_content", suggestionQueryPrompt: "You are an expert content improver. Improve this content [content] by [changing the tone, fixing grammar, making it more concise, and/or making it more engaging]. You will ask first for content, what way it needs to be improved."),
        
            .init(suggestionName: "Brand Tagline".localized(), suggestionInfo: "Create a catchy brand tagline".localized(), suggestionImage: "businessMarketing_brand_tagline", suggestionQueryPrompt: "Create a catchy and memorable tagline that highlights the unique selling proposition of {product/service}. The inital questions you will ask what is product/service."),
        
            .init(suggestionName: "Product Naming".localized(), suggestionInfo: "Generate product naming ideas".localized(), suggestionImage: "businessMarketing_product_naming", suggestionQueryPrompt: "I need a catchy name for my [Product]. The inital questions you will ask what is ''What is product / What kind of product'' "),
        
            .init(suggestionName: "Personalize Mail Response".localized(), suggestionInfo: "Make your emails more personal".localized(), suggestionImage: "email_personalize_mail", suggestionQueryPrompt: "I want to make this email more personal by including specific information I know about the recipient. Can you help me incorporate that into the email? I want to show the recipient that I value our relationship. The email content is: [include the email content] and specific information about the recipient is: [include information unique to them]."),
        
            .init(suggestionName: "Tarot Analysis".localized(), suggestionInfo: "Let's begin by having you choose card from the Tarot deck".localized(), suggestionImage: "astrology_tarot_analysis", suggestionQueryPrompt: "Act like an astrologer. I want you to look at my Tarot. First you will have me choose cards, then you will do tarot analysis by describing the symbols and all other features of the cards."),
        
            .init(suggestionName: "Dietitian".localized(), suggestionInfo: "Clinically tailored nutrition and health recommendations using height, weight, age, and gender info.".localized(), suggestionImage: "healthNutritionSuggestions_dietitian", suggestionQueryPrompt: "You are a nutritional expert and health advisor. You offer advice based on the question asked with the ultimate goal of helping the individual to improve their nutrition and health. You offer factual advice and do not offer opinionated or biased advice. The person will give you their height, weight, age, and sex. You first message should be to meet person and ask 3 short question what you need."),
        
            .init(suggestionName: "Generate Secure Passwords".localized(), suggestionInfo: "Create strong passwords for your security".localized(), suggestionImage: "career_secure_passwords", suggestionQueryPrompt: "You are an expert secure passwort generator and a person who can generate the best secure passwords. . Now, I want you to generate best secure password but that password. First, you will greet the user with the first sentence being ''Hello,'' and then you will genereate 10 passwords."),
        
            .init(suggestionName: "Email Responder".localized(), suggestionInfo: "Generate fastest response for your email".localized(), suggestionImage: "email_responder", suggestionQueryPrompt: "You are an expert Email Responder who can generate the best response for emails. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about Email to reply to."),
        
            .init(suggestionName: "Brainstorming".localized(), suggestionInfo: "Generate new product ideas".localized(), suggestionImage: "creative_idea_brainstorming", suggestionQueryPrompt: "You will do brainstorming for product. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about my product"),
        
    ]
    
}
