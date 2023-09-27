//
//  UseDefaultsMessageManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.09.2023.
//

import Foundation

final class UseDefaultsMessageManager {
    static let shared = UseDefaultsMessageManager()
    
    private let currentAssistantMessageCountKey = "currentAssistantMessageCount"
    
    let maxMessageCount = 5
    
    func canSendMessage() -> Bool {
        if UserDefaults.standard.object(forKey: currentAssistantMessageCountKey) == nil {
            
            UserDefaults.standard.set(0, forKey: currentAssistantMessageCountKey)
        }
        
        let currentMessageCount = UserDefaults.standard.integer(forKey: currentAssistantMessageCountKey)
        
        return currentMessageCount < maxMessageCount
    }
    
    func sendMessage(completion: @escaping (Bool) -> Void) {
        if canSendMessage() {
            // Mesajı gönder
            let currentMessageCount = UserDefaults.standard.integer(forKey: currentAssistantMessageCountKey)
            UserDefaults.standard.set(currentMessageCount + 1, forKey: currentAssistantMessageCountKey)
            
            completion(true)
        } else {
            // Sınıra ulaşıldı, kullanıcıya bilgi ver
            completion(false)
        }
    }
    
}
