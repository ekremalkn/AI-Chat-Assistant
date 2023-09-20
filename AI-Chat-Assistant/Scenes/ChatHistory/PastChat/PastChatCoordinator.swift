//
//  PastChatCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 20.09.2023.
//

import UIKit

final class PastChatCoordinator: Coordinator {
    
    //MARK: - References
    weak var chatHistoryParentCoordinator: ChatHistoryCoordinator?
    private let navigationController: UINavigationController
    private let uiMessages: [UIMessage]
    private let chatHistoryItem: ChatHistoryItem
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController, uiMessages: [UIMessage], chatHistoryItem: ChatHistoryItem) {
        self.navigationController = navigationController
        self.uiMessages = uiMessages
        self.chatHistoryItem = chatHistoryItem
    }
    
    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let pastChatVM = PastChatViewModel(uiMessages: uiMessages, chatHistoryItem: chatHistoryItem, openAIChatService: openAIChatService)
        let pastChatVC = PastChatViewController(viewModel: pastChatVM)
        pastChatVC.pastChatCoordinator = self
        navigationController.pushViewController(pastChatVC, animated: true)
    }
    
    
    func backToChatHistory() {
        navigationController.popViewController(animated: true)
    }
    
    
}
