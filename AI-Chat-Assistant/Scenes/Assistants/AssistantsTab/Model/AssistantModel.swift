//
//  AssistantModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 14.09.2023.
//

import Foundation

// MARK: - AssistantModel
struct AssistantModel: Codable {
    let code: Int?
    let msg: String?
    let data: [Assistant]?
}

// MARK: - Datum
struct Assistant: Codable {
    let uuid: String?
    let tag: String?
    var title, prompt, promptID: String?

    enum CodingKeys: String, CodingKey {
        case uuid, tag, title, prompt
        case promptID = "prompt_id"
    }
}

