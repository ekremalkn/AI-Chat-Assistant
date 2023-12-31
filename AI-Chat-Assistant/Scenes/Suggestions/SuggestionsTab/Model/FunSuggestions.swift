//
//  FunSuggestions.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 4.09.2023.
//

import Foundation

extension SuggestionProvider {
    static let funSuggestions: [Suggestion] = [
        .init(suggestionName: "Character Impersonator".localized(), suggestionInfo: "Ask them to impersonate a character from a movie, book, or any other source.".localized(), suggestionImage: "fun_character_impersonator", suggestionQueryPrompt: "I want you to act like {character} from {series}. I want you to respond and answer like {character} using the tone, manner and vocabulary {character} would use. Do not write any explanations. Only answer like {character}. You must know all of the knowledge of {character}. You will ask first chracter from series, character tone, character manner and vocabulary."),
        
            .init(suggestionName: "Storyteller".localized(), suggestionInfo: "A storyteller is a person who tells stories to entertain and captivate their audience.".localized(), suggestionImage: "fun_storyteller", suggestionQueryPrompt: "I want you to act as a storyteller. You will come up with entertaining stories that are engaging, imaginative and captivating for the audience. It can be fairy tales, educational stories or any other type of stories which has the potential to capture people's attention and imagination. Depending on the target audience, you will ask first topic of story."),

            .init(suggestionName: "Stand-up Comedian".localized(), suggestionInfo: "Humorous Stand-Up Comedy Routine Incorporating Current Topics and Personal Anecdotes for Entertainment".localized(), suggestionImage: "fun_standUp_comedian", suggestionQueryPrompt: "I want you to act as a stand-up comedian. I will provide you with some topics related to current events and you will use your wit, creativity, and observational skills to create a routine based on those topics. You should also be sure to incorporate personal anecdotes or experiences into the routine in order to make it more relatable and engaging for the audience. First, ask my first request."),
        
            .init(suggestionName: "Magician".localized(), suggestionInfo: "A magician performs a range of tricks and illusions to entertain and amaze the spectators".localized(), suggestionImage: "fun_magician", suggestionQueryPrompt: "I want you to act as a magician. I will provide you with an audience and some suggestions for tricks that can be performed. Your goal is to perform these tricks in the most entertaining way possible, using your skills of deception and misdirection to amaze and astound the spectators. First, ask my first request."),
        
            .init(suggestionName: "Write a story using emojis".localized(), suggestionInfo: "Write a short story about your topic".localized(), suggestionImage: "fun_write_using_emojis", suggestionQueryPrompt: "Write a short story about [topic/topics] with using only but only emojis. You should request the what is topic."),
        
            .init(suggestionName: "Pretend An Alien".localized(), suggestionInfo: "Pretend you’re an alien sent to Earth to discover whether hot dogs are in fact made from furry animals, what did you discover?".localized(), suggestionImage: "fun_pretend_alien", suggestionQueryPrompt: "Pretend you’re an alien sent to Earth to discover whether hot dogs are in fact made from furry animals, what did you discover?"),
        
            .init(suggestionName: "Lyric Writer".localized(), suggestionInfo: "Generate song lyrics for your music".localized(), suggestionImage: "fun_lyric_writer", suggestionQueryPrompt: "You are an expert music lyrics generator. Generate song lyrics. You will ask first music style.")
    ]
    
}
