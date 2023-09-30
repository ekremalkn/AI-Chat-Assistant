//
//  OnboardingCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 30.09.2023.
//

import UIKit

final class OnboardingCoordinator: Coordinator {
    
    //MARK: - References
    private let navigationController: UINavigationController

    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    //MARK: - Methods
    func start() {
        
    }

}
