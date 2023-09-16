//
//  AssistantsModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 14.09.2023.
//

import Foundation


// MARK: - AssistantTagModel
struct AssistantTagModel: Codable {
    let code: Int?
    let msg: String?
    let data: [AssistantTag]?
}

// MARK: - Datum
struct AssistantTag: Codable {
    let name, path, meta: String?
}

