//
//  AssistantsPromptEditCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit

protocol AssistantsPromptEditCoordinatorDelegate: AnyObject {
    func assistantsPromptEditCoordinator(_ coordinator: AssistantsPromptEditCoordinator, didSelectButtonFromRewardedAdAlert buttonType: RewardedAdAlertButtonType)
}

final class AssistantsPromptEditCoordinator: Coordinator {
    
    //MARK: - References
    weak var assistantsParentCoordinator: AssistantsCoordinator?
    private let navigationController: UINavigationController
    weak var delegate: AssistantsPromptEditCoordinatorDelegate?
    
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
    
    func openRewardedAdAlert() {
        let rewardedAdAlertCoordinator = RewardedAdAlertCoordinator(navigationController: navigationController)
        childCoordinators.append(rewardedAdAlertCoordinator)
        rewardedAdAlertCoordinator.assistantsPromptEditParentCoordinator = self
        rewardedAdAlertCoordinator.delegate = self
        rewardedAdAlertCoordinator.start()
    }
    
    func openPaywall() {
        let paywallCoordinator = PaywallCoordinator(navigationController: navigationController)
        childCoordinators.append(paywallCoordinator)
        paywallCoordinator.assistantsPromptEditParentCoordinator = self
        paywallCoordinator.start()
    }
    
}

//MARK: - RewardedAdAlertCoordinatorDelegate
extension AssistantsPromptEditCoordinator: RewardedAdAlertCoordinatorDelegate {
    func rewardedAdAlertCoordinator(_ coordinator: RewardedAdAlertCoordinator, didSelectButton buttonType: RewardedAdAlertButtonType) {
        delegate?.assistantsPromptEditCoordinator(self, didSelectButtonFromRewardedAdAlert: buttonType)
    }
    
    
}
