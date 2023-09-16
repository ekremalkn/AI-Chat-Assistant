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
    private let uiMessages: [UIMessage]
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController, uiMessages: [UIMessage]) {
        self.navigationController = navigationController
        self.uiMessages = uiMessages
    }
    
    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let assitantsResponseVM = AssistantsResponseViewModel(uiMessages: uiMessages, openAIChatService: openAIChatService)
        let assistantsResponseVC = AssistantsResponseViewController(viewModel: assitantsResponseVM)
        assistantsResponseVC.assistantsResponseCoordinator = self
        navigationController.pushViewController(assistantsResponseVC, animated: true)
    }


}
