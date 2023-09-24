//
//  PaywallCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import Foundation
import UIKit

final class PaywallCoordinator: Coordinator {

    //MARK: - References
    weak var settingsParentCoordinator: SettingsCoordinator?
    private let navigationController: UINavigationController

    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Init Methods
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Methods
    func start() {
        let paywallVM = PaywallViewModel()
        let paywallVC = PaywallViewController(viewModel: paywallVM)
        paywallVC.paywallCoordinator = self
        navigationController.present(paywallVC, animated: true)
    }


}
