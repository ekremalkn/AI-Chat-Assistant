//
//  MessageManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.09.2023.
//

import Foundation

enum UserMessageStatus {
    case noMessageLimit
    case canSendMessage(_ isSubscribed: Bool)
}

enum AfterMessageSendStatus {
    case showAds
    case showReviewAlert
}

final class MessageManager {
    static let shared = MessageManager()
    
    private let currentAssistantMessageCountKey = "currentAssistantMessageCount"
    private let lastResetDateKey = "lastResetDate"
    
    let maxMessageCount = 10
    
    var freeMessageCount: Int {
        get {
            let currentMessageCount = UserDefaults.standard.integer(forKey: currentAssistantMessageCountKey)
            
            return maxMessageCount - currentMessageCount
        }
    }
    
    private init() {
        
    }
    
    //MARK: - Methods
    func getUserMessageStatus() -> UserMessageStatus {
        if RevenueCatManager.shared.isSubscribe {
            return .canSendMessage(true)
        } else {
            
            if UserDefaults.standard.object(forKey: currentAssistantMessageCountKey) == nil {
                UserDefaults.standard.set(0, forKey: currentAssistantMessageCountKey)
                
                let currentDate = Date()
                UserDefaults.standard.set(currentDate, forKey: lastResetDateKey)
            }
            
            let currentMessageCount = UserDefaults.standard.integer(forKey: currentAssistantMessageCountKey)
            
            // Son sıfırlama tarihini kontrol et
            let lastResetDate = UserDefaults.standard.object(forKey: lastResetDateKey) as? Date
            let currentDate = Date()
            
            if let lastResetDate, currentDate.timeIntervalSince(lastResetDate) >= 24 * 60 * 60 {
                // 24 saat geçti, mesaj sınırlamasını sıfırla
                UserDefaults.standard.set(0, forKey: currentAssistantMessageCountKey)
                
                // Şimdi son sıfırlama tarihini güncelle
                UserDefaults.standard.set(currentDate, forKey: lastResetDateKey)
                
                return .canSendMessage(false)
            } else {
                if currentMessageCount < maxMessageCount {
                    return .canSendMessage(false)
                } else {
                    return .noMessageLimit
                }
            }
        }
    }
    
    func updateMessageLimit() {
        let currentMessageCount = UserDefaults.standard.integer(forKey: currentAssistantMessageCountKey)
        
        if currentMessageCount < maxMessageCount {
            let currentMessageCount = UserDefaults.standard.integer(forKey: currentAssistantMessageCountKey)
            UserDefaults.standard.set(currentMessageCount + 1, forKey: currentAssistantMessageCountKey)
        }
    }
    
}
