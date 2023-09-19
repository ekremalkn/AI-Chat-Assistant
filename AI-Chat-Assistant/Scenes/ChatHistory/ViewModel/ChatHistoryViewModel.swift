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
    
    func numberOfItems() -> Int
}

final class ChatHistoryViewModel {
    
    //MARK: - References
    weak var view: ChatHistoryViewInterface?
    private let chatHistoryService: ChatHistoryService = CoreDataService()
    
    //MARK: - Variables
    var chatHistoryItems: [ChatHistoryItem] = []
    
    //MARK: - Methods
    func fetchChatHistoryItems() {
        let chatHistoryItems = chatHistoryService.fetchChatHistory()
        let sortedChatHistoryItems = chatHistoryItems.sorted { ($0.chatCreationDate ?? Date()) > ($1.chatCreationDate ?? Date()) }
        self.chatHistoryItems = sortedChatHistoryItems
    }

    
}

extension ChatHistoryViewModel: ChatHistoryViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
        fetchChatHistoryItems()
    }
    
    func numberOfItems() -> Int {
        chatHistoryItems.count
    }
    
}
