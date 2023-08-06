//
//  NetworkEndPointCases.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation
import Moya

enum NetworkEndPointCases {
    case sendMessage(messages: [UIMessage])
}

extension NetworkEndPointCases: TargetType {
    var baseURL: URL {
        switch self {
        case .sendMessage:
            guard let url = URL(string: NetworkConstants.openAIBaseURL) else {
                fatalError()
            }
            return url
        }
    }
    
    var path: String {
        ""
    }
    
    var method: Moya.Method {
        .post
    }
    
    var task: Moya.Task {
        switch self {
        case .sendMessage(let messages):
            let requestMessages = messages.map({OpenAIChatMessages(role: $0.role, content: $0.content)})
            let requestBody = OpenAIChatRequestBody(model: "gpt-3.5-turbo", messages: requestMessages)
            return .requestJSONEncodable(requestBody)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendMessage:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(NetworkConstants.openAIapiKey)"
            ]
        }
    }
    
    
}
