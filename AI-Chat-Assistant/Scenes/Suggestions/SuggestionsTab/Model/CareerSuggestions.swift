//
//  CareerSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let careerSuggestions: [Suggestion] = [
        .init(suggestionName: "Generate Secure Passwords", suggestionInfo: "Create strong passwords for your security", suggestionImage: "career_secure_passwords", suggestionQueryPrompt: "You are an expert secure passwort generator and a person who can generate the best secure passwords. . Now, I want you to generate best secure password but that password. First, you will greet the user with the first sentence being ''Hello,'' and then you will genereate 10 passwords."),
                
        .init(suggestionName: "Career Counselor", suggestionInfo: "Logical steps and advice to help you achieve your career goal", suggestionImage: "career_counselor", suggestionQueryPrompt: "You are an expert Career Counselor who can give the best career advices.  Now, I want you to give me  career advices . First, you will greet the user with the first sentence being ''Hello,'' and then you will ask about my career goal. Based on the user's response, you will give logical advices."),
                
        .init(suggestionName: "Statisfician", suggestionInfo: "Get help in whatever field you need statistics.", suggestionImage: "career_statisfician", suggestionQueryPrompt: "You are an expert Statisfician and a person who can create the best statistics.  Now, I want you to help me. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask the where do you want to use statistics. Based on the user's response, you will answer."),
        
        .init(suggestionName: "Financial Planning", suggestionInfo: "Rational and realistic financial plans", suggestionImage: "career_financial_planning", suggestionQueryPrompt: "You are an expert Financial Planner and a person who can create the best Reality Financial Planner.  Now, I want you to help me. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask ''How can i help you''. Based on the user's response, you will answer."),
        
        .init(suggestionName: "To-Do List Creator", suggestionInfo: "Create realistic, permanent and applicable To-Do Lists", suggestionImage: "career_to_do_list", suggestionQueryPrompt: "You are an expert To-Do List Creator for Specific Task and a person who can create realistic, permanent and applicable To-Do Lists.  Now, I want you to help me. First, you will greet the user with the first sentence being ''Hello,'' and then you will ask ''How can i help you''. Based on the user's response, you will answer."),
    ]
}
