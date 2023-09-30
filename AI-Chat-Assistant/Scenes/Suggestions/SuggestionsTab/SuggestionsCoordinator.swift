//
//  HomeCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

protocol SuggestionsCoordinatorDelegate: AnyObject {
    func suggestionsCoordinator(_ coordinator: SuggestionsCoordinator, didSelectModel model: GPTModel)
}

final class SuggestionsCoordinator: Coordinator {
    
    //MARK: - References
    let navigationController: UINavigationController = UINavigationController()
    weak var delegate: SuggestionsCoordinatorDelegate?
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Methods
    func start() {
        let suggestionsVM = SuggestionsViewModel()
        let suggestionsVC = SuggestionsViewController(viewModel: suggestionsVM)
        suggestionsVC.suggestionsCoordinator = self
        suggestionsVC.tabBarItem = .init(title: "Suggestions".localized(), image: .init(named: "chat_lightbulb"), selectedImage: .init(named: "chat_lightbulb_fill"))
        navigationController.setViewControllers([suggestionsVC], animated: false)
    }
    
    func openChatVC() {
        
    }
    
    func openSuggestionsResponseVC(with suggestion: Suggestion, selectedGPTModel: GPTModel) {
        let suggestionsResponseCoordinator = SuggestionsResponseCoordinator(navigationController: navigationController, selectedSuggestion: suggestion, selectedGPTModel: selectedGPTModel)
        childCoordinators.append(suggestionsResponseCoordinator)
        suggestionsResponseCoordinator.suggestionsParentCoordinator = self
        suggestionsResponseCoordinator.start()
    }
    
    func openModelSelectVC(with selectedModel: GPTModel) {
        let modelSelectCoordinator = ModelSelectCoordinator(navigationController: navigationController, model: selectedModel)
        childCoordinators.append(modelSelectCoordinator)
        modelSelectCoordinator.suggestionsParentCoordinator = self
        modelSelectCoordinator.delegate = self
        modelSelectCoordinator.start()
    }
    
    func openChatHistoryVC() {
        let chatHistoryCoordinator = ChatHistoryCoordinator(navigationController: navigationController)
        childCoordinators.append(chatHistoryCoordinator)
        chatHistoryCoordinator.suggestionsParentCoordinator = self
        chatHistoryCoordinator.start()
    }

    func openSettingsVC() {
        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
        childCoordinators.append(settingsCoordinator)
        settingsCoordinator.suggestionsParentCoordinator = self
        settingsCoordinator.start()
    }
    
    func openPaywall() {
        let paywallCoordinator = PaywallCoordinator(navigationController: navigationController)
        childCoordinators.append(paywallCoordinator)
        paywallCoordinator.suggestionsParentCoordinator = self
        paywallCoordinator.start()
    }

}

extension SuggestionsCoordinator: ModelSelectCoordinatorDelegate {
    func modelSelectCoordinator(_ coordinator: ModelSelectCoordinator, didSelectModel model: GPTModel) {
        delegate?.suggestionsCoordinator(self, didSelectModel: model)
    }
    
    
}
