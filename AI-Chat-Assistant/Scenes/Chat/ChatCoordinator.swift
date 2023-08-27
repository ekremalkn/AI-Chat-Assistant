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
    private let  navigationController: UINavigationController
    weak var delegate: ChatCoordinatorDelegate?
    weak var homeParentCoordinator: HomeCoordinator?
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Init Methods
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let homeChatVM = ChatViewModel(openAIChatService: openAIChatService)
        let homeChatVC = ChatViewController(viewModel: homeChatVM)
        homeChatVC.homeChatCoordinator = self
        navigationController.pushViewController(homeChatVC, animated: true)
    }

    func openModelSelectVC(with selectedModel: GPTModel) {
        let modelSelectCoordinator = ModelSelectCoordinator(navigationController: navigationController, model: selectedModel)
        childCoordinators.append(modelSelectCoordinator)
        modelSelectCoordinator.chatParentCoordinator = self
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

