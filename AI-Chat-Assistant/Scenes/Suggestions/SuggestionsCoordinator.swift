//
//  HomeCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class SuggestionsCoordinator: Coordinator {
    
    //MARK: - References
    let navigationController: UINavigationController = UINavigationController()

    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Methods
    func start() {
        let suggestionsVM = SuggestionsViewModel()
        let suggestionsVC = SuggestionsViewController(viewModel: suggestionsVM)
        suggestionsVC.homeCoordinator = self
        suggestionsVC.tabBarItem = .init(title: "Suggestions", image: .init(named: "chat_lightbulb"), selectedImage: .init(named: "chat_lightbulb_fill"))
        navigationController.setViewControllers([suggestionsVC], animated: false)
    }
    
    func openChatVC() {
        
    }


}