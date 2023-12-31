//
//  OpenAIChatService.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation

protocol OpenAIChatService {
    func sendMessage(messages: [UIMessage], model: GPTModel, completion: @escaping (Result<OpenAIChatResponse?, Error>) -> Void)
}

extension NetworkService: OpenAIChatService {
    func sendMessage(messages: [UIMessage], model: GPTModel, completion: @escaping (Result<OpenAIChatResponse?, Error>) -> Void) {
        NetworkManager.shared.request(target: .sendMessage(messages: messages, model: model), completion: completion)
    }

  
}
