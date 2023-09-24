//
//  SettingsCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import UIKit
import MessageUI
import SafariServices

final class SettingsCoordinator: NSObject, Coordinator {
 
    //MARK: - References
    weak var suggestionsParentCoordinator: SuggestionsCoordinator?
    weak var chatParentCoordinator: ChatCoordinator?
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
        let settingsVM = SettingsViewModel()
        let settingsVC = SettingsViewController(viewModel: settingsVM)
        settingsVC.settingsCoordinator = self
        navigationController.pushViewController(settingsVC, animated: true)
    }
    
    func openMail() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setSubject("\(AppInfo.name) Support")
        mailVC.setToRecipients(["\(AppInfo.appEmail)"])
        
        var messageBody = ""
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let systemVersion = UIDevice.current.systemVersion
            
            messageBody = "Chatvantage v\(appVersion) / iOS \(systemVersion)"
        }

        mailVC.setMessageBody(messageBody, isHTML: false)
        navigationController.present(mailVC, animated: true)
    }
    
    func openShareSheetVC(with data: Any) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let shareSheetVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            shareSheetVC.popoverPresentationController?.sourceView = navigationController.view
            navigationController.present(shareSheetVC, animated: true)
        }
    }
    
    func openSafari(with urlString: String) {
        if let URL = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: URL)
            safariViewController.modalPresentationStyle = .pageSheet
            navigationController.pushViewController(safariViewController, animated: true)
        }
    }
    
    func openPaywall() {
        let paywallCoordinator = PaywallCoordinator(navigationController: navigationController)
        childCoordinators.append(paywallCoordinator)
        paywallCoordinator.settingsParentCoordinator = self
        paywallCoordinator.start()
    }

}

//MARK: - MFMailComposeViewControllerDelegate
extension SettingsCoordinator: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        DispatchQueue.main.async {
            controller.dismiss(animated: true)
        }
    }
}


