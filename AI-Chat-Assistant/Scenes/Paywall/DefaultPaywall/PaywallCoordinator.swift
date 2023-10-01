//
//  PaywallCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import Foundation
import UIKit
import SafariServices

protocol PaywallCoordinatorDelegate: AnyObject {
    func paywallCoordinator(_ coordinator: PaywallCoordinator, dismissedPaywall paywall: PaywallViewController)
}

final class PaywallCoordinator: Coordinator {

    //MARK: - References
    weak var pastChatParentCoordinator: PastChatCoordinator?
    weak var assistantsResponseParentCoordinator: AssistantsResponseCoordinator?
    weak var assistantsPromptEditParentCoordinator: AssistantsPromptEditCoordinator?
    weak var homeChatParentCoordinator: ChatCoordinator?
    weak var suggestionsParentCoordinator: SuggestionsCoordinator?
    weak var suggestionsResponeParentCoordinator: SuggestionsResponseCoordinator?
    weak var settingsParentCoordinator: SettingsCoordinator?
    weak var assistantsParentCoordinator: AssistantsCoordinator?
    private let navigationController: UINavigationController

    weak var delegate: PaywallCoordinatorDelegate?
    
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
    
    func openSafari(with urlString: String, onVC: UIViewController) {
        if let URL = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: URL)
            safariViewController.modalPresentationStyle = .pageSheet
            onVC.present(safariViewController, animated: true)
        }
    }
    
    func dismissedPaywall(paywallVC: PaywallViewController) {
        delegate?.paywallCoordinator(self, dismissedPaywall: paywallVC)
    }

}
