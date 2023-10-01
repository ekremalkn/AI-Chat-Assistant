//
//  SplashCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 1.10.2023.
//

import Foundation

final class SplashCoordinator: Coordinator {
    
    //MARK: - References
    weak var appParentCoordinator: AppCoordinator?
    var rootViewController = SplashViewController()
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    
    //MARK: - Methods
    func start() {
        rootViewController.splashCoordinator = self
    }

    func setRootViewControllerToMainTabBarController() {
        
        if UserDefaults.standard.object(forKey: "isOpenedBefore") == nil {
            UserDefaults.standard.set(false, forKey: "isOpenedBefore")
            // show onboarding
        }
        
        let isOpenedBefore = UserDefaults.standard.bool(forKey: "isOpenedBefore")
        
        if isOpenedBefore {
            appParentCoordinator?.delegate?.setRootViewControllerToMainTabBarController()
        } else {
            appParentCoordinator?.delegate?.setRootViewControllerToOnboardingVC()
        }
    }
}
