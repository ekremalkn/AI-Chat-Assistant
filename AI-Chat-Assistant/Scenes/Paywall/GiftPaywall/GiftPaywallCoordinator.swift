//
//  GiftPaywallCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 29.09.2023.
//

import UIKit
import SafariServices

final class GiftPaywallCoordinator: Coordinator {
    
    //MARK: - References
    weak var settingsParentCoordinator: SettingsCoordinator?
    weak var assistantsParentCoordinator: AssistantsCoordinator?
    private let navigationController: UINavigationController

    //MARK: - Variables
    var childCoordinators: [Coordinator] = []

    //MARK: - Init Methods
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //MARK: - Methods
    func start() {
        let giftPaywallVM = GiftPaywallViewModel()
        let giftPaywallVC = GiftPaywallViewController(viewModel: giftPaywallVM)
        giftPaywallVC.giftPaywallCoordinator = self
        navigationController.present(giftPaywallVC, animated: true)
    }

    func openSafari(with urlString: String, onVC: UIViewController) {
        if let URL = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: URL)
            safariViewController.modalPresentationStyle = .pageSheet
            onVC.present(safariViewController, animated: true)
        }
    }

}
