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
        assistantsVC.tabBarItem = .init(title: "Assistants", image: .init(named: "chat_assistants"), selectedImage: .init(named: "chat_assistants"))
        navigationController.setViewControllers([assistantsVC], animated: false)
    }

    


}
