//
//  MainCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation

final class MainCoordinator: Coordinator {
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    var rootViewController = MainTabBarController()
    
    //MARK: - Init Methods
    
    //MARK: - Methods
    func start() {
        let suggestionsCoordinator = SuggestionsCoordinator()
        suggestionsCoordinator.start()
        childCoordinators.append(suggestionsCoordinator)
        
        let chatCoordinator = ChatCoordinator()
        chatCoordinator.start()
        childCoordinators.append(chatCoordinator)
        
        let assistantsCoordinator  = AssistantsCoordinator()
        assistantsCoordinator.start()
        childCoordinators.append(assistantsCoordinator)
        
        rootViewController.viewControllers = [
            suggestionsCoordinator.navigationController,
            chatCoordinator.navigationController,
            assistantsCoordinator.navigationController
        ]
    }
    
    
}
