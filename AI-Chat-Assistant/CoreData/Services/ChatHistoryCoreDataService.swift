//
//  ChatHistoryService.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import CoreData

protocol ChatHistoryCoreDataService {
    func addChatHistoryToCoreData(chatCreationDate: Date, chatTitleText: String, chatSubTitleText: String?, gptModel: GPTModel, chatMessages: [ChatMessageItem])
    func addChatMessageToCoreData(chatHistoryItem: ChatHistoryItem, uiMessage: UIMessage)
    func deleteChatMessageFromCoreData(chatHistoryItem: ChatHistoryItem, chatMessageItem: ChatMessageItem)
    func fetchChatHistory(completion: @escaping ([ChatHistoryItem]) -> Void)
    func deleteChatHistoryItem(_ chatHistoryItem: ChatHistoryItem, completion: @escaping (_ isDeleted: Bool) -> Void)
}

extension CoreDataService: ChatHistoryCoreDataService {
    func addChatHistoryToCoreData(chatCreationDate: Date, chatTitleText: String, chatSubTitleText: String?, gptModel: GPTModel, chatMessages: [ChatMessageItem]) {
            let chatHistoryItem = ChatHistoryItem(context: viewContext)
            chatHistoryItem.chatCreationDate = chatCreationDate
            chatHistoryItem.chatTitleText = chatTitleText
            chatHistoryItem.chatSubTitleText = chatSubTitleText
            chatHistoryItem.chatMessages = NSSet(array: chatMessages)
            chatHistoryItem.gptModel = gptModel.modelRequestName

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
        
        CoreDataManager.shared.persistentContainer.performBackgroundTask { viewContext in
            chatHistoryItem.removeFromChatMessages(chatMessageItem)
            
            try? viewContext.save()
        }
    }
    
    func fetchChatHistory(completion: @escaping ([ChatHistoryItem]) -> Void) {
        viewContext.perform { [weak self] in
            guard let self else { return }
            
            let fetchRequest: NSFetchRequest<ChatHistoryItem> = ChatHistoryItem.fetchRequest()
            
            do {
                let chatHistoryItems = try viewContext.fetch(fetchRequest)
                
                completion(chatHistoryItems)
            } catch {
                completion([])
            }
        }
    }
    
    func deleteChatHistoryItem(_ chatHistoryItem: ChatHistoryItem, completion: @escaping (_ isDeleted: Bool) -> Void) {
        
        viewContext.perform { [weak self] in
            guard let self else { return }
            
            viewContext.delete(chatHistoryItem)
            
            try? viewContext.save()
            
            completion(true)
        }
        
    }
    
    
}
