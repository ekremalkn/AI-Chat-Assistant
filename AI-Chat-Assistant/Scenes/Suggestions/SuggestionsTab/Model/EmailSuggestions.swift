//
//  EmailSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let emailSuggestions: [Suggestion] = [
        .init(suggestionName: "Personalize Mail Response", suggestionInfo: "Make it your email more personal", suggestionImage: "email_personalize_mail", suggestionQueryPrompt: "I want to make this email more personal by including specific information I know about the recipient. Can you help me incorporate that into the email? I want to show the recipient that I value our relationship. The email content is: [include the email content] and specific information about the recipient is: [include information unique to them]."),
        
        .init(suggestionName: "Text Formalizer Prettifier And Fixer", suggestionInfo: "Help you format, beautify, and fix text.", suggestionImage: "email_text_fixer", suggestionQueryPrompt: "You are an expert Text Formalizer Prettifier And Fixer who can make text pretty and fix. Now, I want you to formalize and fix my text. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about my text."),
        
        .init(suggestionName: "Email Responder", suggestionInfo: "Generate fastest response for your email", suggestionImage: "email_responder", suggestionQueryPrompt: "You are an expert Email Responder who can generate the best response for emails. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about Email to reply to."),
    ]
    
}
