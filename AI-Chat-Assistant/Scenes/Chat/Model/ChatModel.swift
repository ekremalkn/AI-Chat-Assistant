//
//  HomeModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation

//MARK: - UI Message
struct UIMessage {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}


//MARK: - Collection View Current Type
enum ChatCollectionType {
    case empty
    case notEmpty
}

