//
//  EducationSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let educationSuggestions: [Suggestion] = [
        .init(suggestionName: "Google/Powerpoint Slides", suggestionInfo: "Use \(AppName.name) to create slide content for your classroom instruction", suggestionImage: "suggestion_education_powerpoint", suggestionQueryPrompt: "You are an expert teacher and instructional designer. Create the content for a slide deck on [topic/subject]. The slides should be formatted with a header and then a set of bullets for each slide. Change the variety of each slide including questions and activities. The last slide should include text for a formative assessment. Also include a description of any image that should be included on the slide. You will ask for topic or subject."),
        
            .init(suggestionName: "Emoji Translator", suggestionInfo: "Use \(AppName.name) to translate a written piece of text into emojis for a fun", suggestionImage: "suggestion_education_emoji_translator", suggestionQueryPrompt: "You are an emoji expert. Using only emojis, translate the following text to emojis."),
        
            .init(suggestionName: "Email Responses", suggestionInfo: "Craft responses for your important emails", suggestionImage: "suggestion_education_email_responses", suggestionQueryPrompt: "Create a response to this email [email content or issue raised in email] that provides this response [response]. You will ask first for email content, response, response tone, response length and make a list. "),
        
            .init(suggestionName: "Poems", suggestionInfo: "Use \(AppName.name) to create custom poems on a variety of topics and styles", suggestionImage: "suggestion_education_poems", suggestionQueryPrompt: "You are an expert poet and teacher. Create a [type of poem] on [subject]. The length of the poem should be [length] and include these key vocabulary words: [vocabulary]. Identify the poet’s work that has inspired your poem. You will ask first for type of poem, poem length, vocabulary words to include and make a list."),
                
            .init(suggestionName: "Newsletters", suggestionInfo: "Write classrom and school newsletters for families using an AI Chatbot", suggestionImage: "suggestion_education_newsletters", suggestionQueryPrompt: "You are an expert skilled writer. Write a [daily/ weekly /monthly] newsletter that I can send to the [person]. Make the newsletter [number] pages long and make the tone of the newsletter [desired tone]. You will ask first for frequency of sending letters, recipient person, newsletter pages long, desired tone and make a list."),
        
            .init(suggestionName: "Improve your Content", suggestionInfo: "Use \(AppName.name) to act as your editor to improve any content you need help with", suggestionImage: "suggestion_education_improve_content", suggestionQueryPrompt: "You are an expert content improver. Improve this content [content] by [changing the tone, fixing grammar, making it more concise, and/or making it more engaging]. You will ask first for content, what way it needs to be improved."),
        
            .init(suggestionName: "Idea Generator", suggestionInfo: "Brainstrom ideas for your proffessional develeopment using an AI chatbot", suggestionImage: "suggestion_education_idea_generator", suggestionQueryPrompt: "You are an expert administrator, proficient in planning and organizing. Generate [number] ideas for on the topic of [topic]. The idea should focus on: [specific content]. The idea should be engaging, and applicable for [intended audience]. You will ask first topic of idea, number of idea, specific content to focus."),
        
            .init(suggestionName: "Help Me Understand...", suggestionInfo: "Use \(AppName.name) to help you understand a book, passage or topic", suggestionImage: "suggestion_education_help_understand", suggestionQueryPrompt: "You are an expert Bookworm. I want to understand what this [book title] by [author] from [chapter/section/act] means in the context of the [piece/play/book/article]. You will ask first [chapter/section/act], [piece/play/book/article]."),
        
            .init(suggestionName: "Vocabulary Lists", suggestionInfo: "Create vocabulary lists and quizzes with one tap", suggestionImage: "suggestion_education_vocabulary_lists", suggestionQueryPrompt: "You’re an expert teacher with expertise in teaching reading as well as vocabulary acquisition and application. Please create a vocabulary list with [number] of words for the following [topic]. Avoid any controversial words, inappropriate words, and proper nouns. Provide two versions: one with the words only, and one with words and definitions in friendly language. You will ask first number of words, words for the follwoing topic."),
                
            .init(suggestionName: "Explain it to Me Like...", suggestionInfo: "Use \(AppName.name) to simplify complex topics", suggestionImage: "suggestion_education_explain_tome_like", suggestionQueryPrompt: "You are an expert teacher with the ability to explain complex topics in simpler terms. Explain the concept of [topic] in simple terms.You will ask first concept of topic."),
   
            .init(suggestionName: "Real World Examples", suggestionInfo: "Bring an activity to life with real world examples", suggestionImage: "suggestion_education_real_examples", suggestionQueryPrompt: "You are an expert educator that is great at transforming dry course topics into engaging, relevant lessons. Please create [number] real world examples of the [topic]. The simpler and more engaging the better. You will ask first number of examples, topic."),
        
            .init(suggestionName: "Critical Thinking Questions", suggestionInfo: "Create open-ended, higher order thinking questions", suggestionImage: "suggestion_education_critical_questions", suggestionQueryPrompt: "You are an expert educator and instructional designer. Create a list of [number] open-ended, critical thinking questions for [subject, and topic]. You will ask first number of list, critical thinking questions for subject or topic."),
        
            .init(suggestionName: "Studying Help", suggestionInfo: "Use \(AppName.name) to help a student study based on their class notes", suggestionImage: "suggestion_education_studying_help", suggestionQueryPrompt: "I’m a [grade level and subject] student preparing for an upcoming [topic and specific type of assessment]. Below are the notes I’ve taken for the test. Based on my notes, can you generate a practice test to help me prepare? You will ask first grade level, topic, specific type of assessment."),
        
    ]
    
}
