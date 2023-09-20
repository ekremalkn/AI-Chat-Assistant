//
//  ChatHistoryService.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import CoreData

protocol ChatHistoryService {
    func addChatHistoryToCoreData(chatCreationDate: Date, chatTitleText: String, chatSubTitleText: String?, chatMessages: [ChatMessageItem])
    func addChatMessageToCoreData(chatHistoryItem: ChatHistoryItem, uiMessage: UIMessage)
    func deleteChatMessageFromCoreData(chatHistoryItem: ChatHistoryItem, chatMessageItem: ChatMessageItem)
    func fetchChatHistory() -> [ChatHistoryItem]
    func deleteChatHistoryItem(_ chatHistoryItem: ChatHistoryItem, completion: @escaping (_ isDeleted: Bool) -> Void)
}

extension CoreDataService: ChatHistoryService {
    func addChatHistoryToCoreData(chatCreationDate: Date, chatTitleText: String, chatSubTitleText: String?, chatMessages: [ChatMessageItem]) {
        let chatHistoryItem = ChatHistoryItem(context: viewContext)
        chatHistoryItem.chatCreationDate = chatCreationDate
        chatHistoryItem.chatTitleText = chatTitleText
        chatHistoryItem.chatSubTitleText = chatSubTitleText
        chatHistoryItem.chatMessages = NSSet(array: chatMessages)
        
        CoreDataManager.shared.saveContext()
    }
    
    func addChatMessageToCoreData(chatHistoryItem: ChatHistoryItem, uiMessage: UIMessage) {
        let chatMessageItem = ChatMessageItem(context: viewContext)
        chatMessageItem.id = uiMessage.id
        chatMessageItem.content = uiMessage.content
        chatMessageItem.createAt = uiMessage.createAt
        chatMessageItem.role = uiMessage.role.rawValue
        
        chatHistoryItem.addToChatMessages(chatMessageItem)
        
        CoreDataManager.shared.saveContext()
    }
    
    func deleteChatMessageFromCoreData(chatHistoryItem: ChatHistoryItem, chatMessageItem: ChatMessageItem) {
        chatHistoryItem.removeFromChatMessages(chatMessageItem)
        
        CoreDataManager.shared.saveContext()
    }
    
    func fetchChatHistory() -> [ChatHistoryItem] {
        let fetchRequest: NSFetchRequest<ChatHistoryItem> = ChatHistoryItem.fetchRequest()
        
        return (try? viewContext.fetch(fetchRequest)) ?? []
    }
    
    func deleteChatHistoryItem(_ chatHistoryItem: ChatHistoryItem, completion: @escaping (_ isDeleted: Bool) -> Void) {
        CoreDataManager.shared.delete(object: chatHistoryItem) { isDeleted in
            completion(isDeleted)
        }
    }
    
    
}
