//
//  NetworkEndPointCases.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation
import Moya

enum NetworkEndPointCases {
    case sendMessage(messages: [UIMessage], model: GPTModel)
    case fetchAssistantTags
    case fetchPromptsList(tag: String)
}

extension NetworkEndPointCases: TargetType {
    var baseURL: URL {
        switch self {
        case .sendMessage:
            guard let url = URL(string: NetworkConstants.openAIBaseURL) else {
                fatalError()
            }
            return url
        case .fetchAssistantTags, .fetchPromptsList:
            guard let url = URL(string: NetworkConstants.assistantListBaseURL) else {
                fatalError()
            }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .sendMessage:
            return ""
        case .fetchAssistantTags:
            return "/tag-list"
        case .fetchPromptsList:
            return "/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendMessage:
            return .post
        case .fetchAssistantTags, .fetchPromptsList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .sendMessage(let messages, let model):
            let requestMessages = messages.map({OpenAIChatMessages(role: $0.role, content: $0.content)})
            let requestBody = OpenAIChatRequestBody(model: model.modelRequestName,
                                                    messages: requestMessages)
            return .requestJSONEncodable(requestBody)
        case .fetchAssistantTags:
            return .requestPlain
        case .fetchPromptsList(let tag):
            let requestParameters: [String : Any] = [
                "tag" : tag
            ]
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        
        switch self {
        case .sendMessage:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(NetworkConstants.openAIapiKey)"
            ]
        case .fetchAssistantTags, . fetchPromptsList:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
