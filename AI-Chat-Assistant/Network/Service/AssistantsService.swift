//
//  AssistantsService.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 14.09.2023.
//

import Foundation

protocol  AssistantsService {
    func fetchAssistantTags(completion: @escaping (Result<AssistantTagModel?, Error>) -> Void)
    func fetchPromptsList(for tag: String, completion: @escaping (Result<AssistantModel?, Error>) -> Void)
    
}

extension NetworkService: AssistantsService {
    func fetchAssistantTags(completion: @escaping (Result<AssistantTagModel?, Error>) -> Void) {
        NetworkManager.shared.request(target: .fetchAssistantTags, completion: completion)
    }
    
    func fetchPromptsList(for tag: String, completion: @escaping (Result<AssistantModel?, Error>) -> Void) {
        NetworkManager.shared.request(target: .fetchPromptsList(tag: tag), completion: completion)
    }
    
    
}
