//
//  ChatHistoryViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import Foundation

protocol ChatHistoryViewModelInterface {
    var view: ChatHistoryViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func numberOfItems() -> Int
    func didSelectItemAt(indexPath: IndexPath)
}

final class ChatHistoryViewModel {
    
    //MARK: - References
    weak var view: ChatHistoryViewInterface?
    private let chatHistoryService: ChatHistoryCoreDataService = CoreDataService()
    
    //MARK: - Variables
    var chatHistoryItems: [ChatHistoryItem] = []
    
    //MARK: - Methods
    func fetchChatHistoryItems() {
        chatHistoryService.fetchChatHistory { [weak self] chatHistoryItems in
            guard let self else { return }
            let sortedChatHistoryItems = chatHistoryItems.sorted { ($0.chatCreationDate ?? Date()) > ($1.chatCreationDate ?? Date()) }
            self.chatHistoryItems = sortedChatHistoryItems
            
            view?.reloadChatHistoryItems()
        }
        
    }
    
    
}

extension ChatHistoryViewModel: ChatHistoryViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func viewWillAppear() {
        fetchChatHistoryItems()
    }
    
    func numberOfItems() -> Int {
        chatHistoryItems.count
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let selectedChatHistoryItem = chatHistoryItems[indexPath.item]
        if let chatMessageItems = selectedChatHistoryItem.chatMessages?.allObjects as? [ChatMessageItem] {
            let uiMessages: [UIMessage] = chatMessageItems.map {
                
                if let uuid = $0.id, let role = $0.role, let senderRole = SenderRole(rawValue: role), let content = $0.content, let createAt = $0.createAt {
                    return UIMessage(id: uuid, role: senderRole, content: content, createAt: createAt)
                }
                
                return UIMessage(id: UUID(), role: .assistant, content: "Hi, how can i help you".localized(), createAt: Date())
            }
            
            let sortedUIMessages = uiMessages.sorted { $0.createAt < $1.createAt }
            
            view?.openPastChatVC(uiMessages: sortedUIMessages, chatHistoryItem: selectedChatHistoryItem)
        }
    }
    
    
}
