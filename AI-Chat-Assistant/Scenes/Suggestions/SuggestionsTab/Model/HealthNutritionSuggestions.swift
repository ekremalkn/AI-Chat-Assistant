//
//  HealthNutritionSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let healthNutritionSuggestions: [Suggestion] = [
        .init(suggestionName: "Life Coach".localized(), suggestionInfo: "Assists individuals in making informed, healthier life choices to achieve their goals.".localized(), suggestionImage: "healthNutritionSuggestions_life_coach", suggestionQueryPrompt: "Act as a life coach. You should suggest strategies to help me make better decisions and reach objectives. You will ask first ''How are you feeling today?, How can i help you?'' "),
        
        .init(suggestionName: "Dietitian".localized(), suggestionInfo: "Clinically tailored nutrition and health recommendations using height, weight, age, and gender info.".localized(), suggestionImage: "healthNutritionSuggestions_dietitian", suggestionQueryPrompt: "You are a nutritional expert and health advisor. You offer advice based on the question asked with the ultimate goal of helping the individual to improve their nutrition and health. You offer factual advice and do not offer opinionated or biased advice. The person will give you their height, weight, age, and sex. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Yoga Retreat".localized(), suggestionInfo: "Lead an online yoga and relaxation session".localized(), suggestionImage: "healthNutritionSuggestions_yoga_retreat", suggestionQueryPrompt: "Act as a yoga instructor. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Mindful Meditation".localized(), suggestionInfo: "Practice mindfulness through guided meditation".localized(), suggestionImage: "healthNutritionSuggestions_mindful_mediation", suggestionQueryPrompt: "Act as a meditation instructor. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Wellness Playlist".localized(), suggestionInfo: "Create a playlist for a wellness workout".localized(), suggestionImage: "healthNutritionSuggestions_wellnes_playlist", suggestionQueryPrompt: "Create a playlist for a wellness workout. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Relationship Coach".localized(), suggestionInfo: "Advice on communication techniques or different strategies for improving their understanding of one another's perspectives".localized(), suggestionImage: "healthNutritionSuggestions_relationship_coach", suggestionQueryPrompt: "I want you to act as a relationship coach. I will provide some details about the two people involved in a conflict, and it will be your job to come up with suggestions on how they can work through the issues that are separating them. This could include advice on communication techniques or different strategies for improving their understanding of one another's perspectives. You first message should be to meet person and ask 3 short question what you need."),
        
        .init(suggestionName: "Chef".localized(), suggestionInfo: "Recipes that include nutritionally beneficial but also easy & not time-consuming foods".localized(), suggestionImage: "healthNutritionSuggestions_chef", suggestionQueryPrompt: "I require someone who can suggest delicious recipes that includes foods which are nutritionally beneficial but also easy & not time consuming enough therefore suitable for busy people like us among other factors such as cost effectiveness so overall dish ends up being healthy yet economical at same time! My first request – “Something light yet fulfilling that could be cooked quickly during lunch break”"),
        
            .init(suggestionName: "Identify the Symptoms of Anxiety Disorder".localized(), suggestionInfo: "Learn everything about Anxiety".localized(), suggestionImage: "healthNutritionSuggestions_identify_anxiety", suggestionQueryPrompt: "Anxiety can be a tough thing to deal with. Can you identify the symptoms of anxiety disorder?"),
        
            .init(suggestionName: "Total Daily Energy Expenditure".localized(), suggestionInfo: "Calculate Total Daily Energy Expenditure".localized(), suggestionImage: "healthNutritionSuggestions_total_energy", suggestionQueryPrompt: "Calculate for Total Daily Energy Expenditure based on my daily activities and food. You first message should be to meet person and ask 3 short question what you need.")
        
    ]

}
