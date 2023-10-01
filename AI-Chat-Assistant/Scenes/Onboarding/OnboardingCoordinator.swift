//
//  OnboardingCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 30.09.2023.
//

import UIKit

final class OnboardingCoordinator: Coordinator {
    
    //MARK: - References
    weak var appParentCoordinator: AppCoordinator?
    var rootViewController = OnboardingViewController()
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    
    //MARK: - Methods
    func start() {
        rootViewController.onboardingCoordinator = self
    }
    
    func setRootViewControllerToMainTabBarController() {
        appParentCoordinator?.delegate?.setRootViewControllerToMainTabBarController()
    }
    
}
