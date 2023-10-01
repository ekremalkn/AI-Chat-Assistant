//
//  AppCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit

protocol AppCoordinatorDelegate: AnyObject {
    func setRootViewControllerToMainTabBarController()
    
    func setRootViewControllerToOnboardingVC()
}

final class AppCoordinator: Coordinator {
    
    //MARK: - References
    let window: UIWindow
    weak var delegate: AppCoordinatorDelegate?
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Init Methods
    init(window: UIWindow) {
        self.window = window
        delegate = self
    }
    
    func start() {
        let splashCoordinator = SplashCoordinator()
        splashCoordinator.appParentCoordinator = self
        childCoordinators.append(splashCoordinator)
        window.rootViewController = splashCoordinator.rootViewController
        splashCoordinator.start()
    }


}

extension AppCoordinator: AppCoordinatorDelegate {
    func setRootViewControllerToMainTabBarController() {
        let mainCoordinator = MainCoordinator()
        childCoordinators.append(mainCoordinator)
        window.rootViewController = mainCoordinator.rootViewController
        mainCoordinator.start()
    }
    
    func setRootViewControllerToOnboardingVC() {
        let onboardingCoordinator = OnboardingCoordinator()
        onboardingCoordinator.appParentCoordinator = self
        childCoordinators.append(onboardingCoordinator)
        window.rootViewController = onboardingCoordinator.rootViewController
        onboardingCoordinator.start()
    }
    
    
}
