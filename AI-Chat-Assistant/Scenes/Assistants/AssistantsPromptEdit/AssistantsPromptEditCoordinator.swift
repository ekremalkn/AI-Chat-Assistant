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
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController, assistant: Assistant) {
        self.navigationController = navigationController
        self.assistant = assistant
    }
    
    //MARK: - Methods
    func start() {
        let assistantsPromptEditVM = AssistantsPromptEditViewModel(assistant: assistant)
        let assistantsPromptEditVC = AssistantsPromptEditViewController(viewModel: assistantsPromptEditVM)
        assistantsPromptEditVC.assistantsPromptEditCoordinator = self
        navigationController.pushViewController(assistantsPromptEditVC, animated: true)
    }
    
}
