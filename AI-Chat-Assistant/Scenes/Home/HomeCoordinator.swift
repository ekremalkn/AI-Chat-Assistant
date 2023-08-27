//
//  HomeCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    //MARK: - References
    let navigationController: UINavigationController = UINavigationController()

    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Methods
    func start() {
        let homeVM = HomeViewModel()
        let homeVC = HomeViewController(viewModel: homeVM)
        homeVC.homeCoordinator = self
        homeVC.tabBarItem = .init(title: "Home", image: .init(systemName: "square.grid.3x1.below.line.grid.1x2"), selectedImage: .init(systemName: "square.grid.3x1.below.line.grid.1x2.fill"))
        navigationController.setViewControllers([homeVC], animated: false)
    }
    
    func openChatVC() {
        let chatCoordinator = ChatCoordinator(navigationController: navigationController)
        childCoordinators.append(chatCoordinator)
        chatCoordinator.homeParentCoordinator = self
        chatCoordinator.start()
    }


}
