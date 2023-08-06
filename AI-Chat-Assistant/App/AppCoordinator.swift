//
//  AppCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    //MARK: - References
    let window: UIWindow
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Init Methods
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainCoordinator = MainCoordinator()
        childCoordinators.append(mainCoordinator)
        window.rootViewController = mainCoordinator.rootViewController
        mainCoordinator.start()
    }


}
