//
//  AssistantsCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import UIKit

final class AssistantsCoordinator: Coordinator {
    
    //MARK: - References
    let navigationController: UINavigationController = UINavigationController()

    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    
    //MARK: - Methods
    func start() {
        let assistantService: AssistantsService = NetworkService()
        let assistantsVM = AssistantsViewModel(assistantsService: assistantService)
        let assistantsVC = AssistantsViewController(viewModel: assistantsVM)
        assistantsVC.assistantsCoordinator = self
        assistantsVC.tabBarItem = .init(title: "Assistants".localized(), image: .init(named: "chat_assistants"), selectedImage: .init(named: "chat_assistants"))
        navigationController.setViewControllers([assistantsVC], animated: false)
    }

    func openAssistantsPromptEdit(with assistant: Assistant, translatedAssistant: TranslatedAssistant) {
        let assistantsPromptEditCoordinator = AssistantsPromptEditCoordinator(navigationController: navigationController, assistant: assistant, translatedAssistant: translatedAssistant)
        childCoordinators.append(assistantsPromptEditCoordinator)
        assistantsPromptEditCoordinator.assistantsParentCoordinator = self
        assistantsPromptEditCoordinator.start()
    }

    func openChatHistoryVC() {
        let chatHistoryCoordinator = ChatHistoryCoordinator(navigationController: navigationController)
        childCoordinators.append(chatHistoryCoordinator)
        chatHistoryCoordinator.assistantsParentCoordinator = self
        chatHistoryCoordinator.start()
    }
    
    func openSettingsVC() {
        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
        childCoordinators.append(settingsCoordinator)
        settingsCoordinator.assistantsParentCoordinator = self
        settingsCoordinator.start()
    }
    
    func openGiftPaywall() {
        let giftPaywallCoordinator = GiftPaywallCoordinator(navigationController: navigationController)
        childCoordinators.append(giftPaywallCoordinator)
        giftPaywallCoordinator.assistantsParentCoordinator = self
        giftPaywallCoordinator.start()
    }
    
}
