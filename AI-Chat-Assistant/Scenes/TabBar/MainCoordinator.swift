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
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
        
        rootViewController.viewControllers = [
            homeCoordinator.navigationController
        ]
    }
    
    
}
