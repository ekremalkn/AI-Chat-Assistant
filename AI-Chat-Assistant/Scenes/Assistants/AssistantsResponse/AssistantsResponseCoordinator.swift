//
//  AssistantsResponseCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit


final class AssistantsResponseCoordinator: Coordinator {
    
    //MARK: - References
    weak var assistantsPromptEditParentCoordinator: AssistantsPromptEditCoordinator?
    private let navigationController: UINavigationController
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    private let mainMessages: [UIMessage]
    private let selectedGPTModel: GPTModel
    private let selectedAssistant: Assistant
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController, mainMessages: [UIMessage], selectedGPTModel: GPTModel, selectedAssistant: Assistant) {
        self.navigationController = navigationController
        self.mainMessages = mainMessages
        self.selectedGPTModel = selectedGPTModel
        self.selectedAssistant = selectedAssistant
    }
    
    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let assitantsResponseVM = AssistantsResponseViewModel(mainMessages: mainMessages, openAIChatService: openAIChatService, selectedGPTModel: selectedGPTModel, assistant: selectedAssistant)
        let assistantsResponseVC = AssistantsResponseViewController(viewModel: assitantsResponseVM)
        assistantsResponseVC.assistantsResponseCoordinator = self
        navigationController.pushViewController(assistantsResponseVC, animated: true)
    }


}
