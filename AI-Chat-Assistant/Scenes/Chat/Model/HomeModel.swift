//
//  HomeModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation



//MARK: - UI Messages Different
struct UIMessage {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}
