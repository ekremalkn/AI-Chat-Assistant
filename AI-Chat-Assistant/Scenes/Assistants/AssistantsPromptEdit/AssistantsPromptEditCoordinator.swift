//
//  AssistantsPromptEditCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit

final class AssistantsPromptEditCoordinator: Coordinator {
    
    //MARK: - References
    weak var assistantsParentCoordinator: AssistantsCoordinator?
    private let navigationController: UINavigationController
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    private let assistant: Assistant
    private let translatedAssitant: TranslatedAssistant
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController, assistant: Assistant, translatedAssistant: TranslatedAssistant) {
        self.navigationController = navigationController
        self.assistant = assistant
        self.translatedAssitant = translatedAssistant
    }
    
    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let assistantsPromptEditVM = AssistantsPromptEditViewModel(openAIChatService: openAIChatService, assistant: assistant, translatedAssitant: translatedAssitant)
        let assistantsPromptEditVC = AssistantsPromptEditViewController(viewModel: assistantsPromptEditVM)
        assistantsPromptEditVC.assistantsPromptEditCoordinator = self
        navigationController.pushViewController(assistantsPromptEditVC, animated: true)
    }
    
    func openAssistantsResponseVC(with uiMessages: [UIMessage], updatedAssitant: Assistant, selectedGPTModel: GPTModel) {
        let assistantsResponseCoordinator = AssistantsResponseCoordinator(navigationController: navigationController, mainMessages: uiMessages, selectedGPTModel: selectedGPTModel, selectedAssistant: updatedAssitant)
        childCoordinators.append(assistantsResponseCoordinator)
        assistantsResponseCoordinator.assistantsPromptEditParentCoordinator = self
        assistantsResponseCoordinator.start()
    }
    
    func openPaywall() {
        let paywallCoordinator = PaywallCoordinator(navigationController: navigationController)
        childCoordinators.append(paywallCoordinator)
        paywallCoordinator.assistantsPromptEditParentCoordinator = self
        paywallCoordinator.start()
    }
    
}
