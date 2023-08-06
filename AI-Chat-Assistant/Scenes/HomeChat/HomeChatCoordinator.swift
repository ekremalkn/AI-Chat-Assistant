//
//  HomeChatCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit

final class HomeChatCoordinator: Coordinator {
    
    //MARK: - References
    var navigationController: UINavigationController = UINavigationController()

    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let homeChatVM = HomeChatViewModel(openAIChatService: openAIChatService)
        let homeChatVC = HomeChatViewController(viewModel: homeChatVM)
        homeChatVC.homeChatCoordinator = self
        homeChatVC.tabBarItem = .init(title: "Chat", image: .init(systemName: "plus.message"), selectedImage: .init(systemName: "plus.message.fill"))
        navigationController.setViewControllers([homeChatVC], animated: false)
    }


}
