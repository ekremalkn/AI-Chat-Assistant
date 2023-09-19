//
//  ChatHistoryCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import UIKit

final class ChatHistoryCoordinator: Coordinator {
    
    //MARK: - References
    weak var suggestionsParentCoordinator: SuggestionsCoordinator?
    weak var assistantsParentCoordinator: AssistantsCoordinator?
    private let navigationController: UINavigationController
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //MARK: - Methods
    func start() {
        let chatHistoryVM = ChatHistoryViewModel()
        let chatHistoryVC = ChatHistoryViewController(viewModel: chatHistoryVM)
        chatHistoryVC.chatHistoryCoordinator = self
        navigationController.pushViewController(chatHistoryVC, animated: true)
    }


}
