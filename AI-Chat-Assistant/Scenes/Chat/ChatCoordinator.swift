//
//  ChatCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit

protocol ChatCoordinatorDelegate: AnyObject {
    func chatCoordinator(_ coordinator: ChatCoordinator, didSelectModel model: GPTModel)
}

final class ChatCoordinator: Coordinator {
    
    //MARK: - References
    var navigationController: UINavigationController = UINavigationController()
    weak var delegate: ChatCoordinatorDelegate?
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let homeChatVM = ChatViewModel(openAIChatService: openAIChatService)
        let homeChatVC = ChatViewController(viewModel: homeChatVM)
        homeChatVC.homeChatCoordinator = self
        homeChatVC.tabBarItem = .init(title: "Chat", image: .init(systemName: "plus.message"), selectedImage: .init(systemName: "plus.message.fill"))
        navigationController.setViewControllers([homeChatVC], animated: false)
    }

    func openModelSelectVC(with selectedModel: GPTModel) {
        let modelSelectCoordinator = ModelSelectCoordinator(navigationController: navigationController, model: selectedModel)
        childCoordinators.append(modelSelectCoordinator)
        modelSelectCoordinator.homeChatParentCoordinator = self
        modelSelectCoordinator.delegate = self
        modelSelectCoordinator.start()
    }

}

//MARK: - ModelSelectCoordinatorDelegate
extension ChatCoordinator: ModelSelectCoordinatorDelegate {
    func modelSelectCoordinator(_ coordinator: ModelSelectCoordinator, didSelectModel model: GPTModel) {
        delegate?.chatCoordinator(self, didSelectModel: model)
    }
    
}

