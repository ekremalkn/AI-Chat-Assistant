//
//  OpenAIChatBody.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation

//MARK: - OpenAIChatRequestBody
struct OpenAIChatRequestBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessages]
}

struct OpenAIChatMessages: Encodable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Encodable {
    case system
    case user
    case assistant
}

