//
//  RewardedAdAlertCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.10.2023.
//

import UIKit

protocol RewardedAdAlertCoordinatorDelegate: AnyObject {
    func rewardedAdAlertCoordinator(_ coordinator: RewardedAdAlertCoordinator, didSelectButton buttonType: RewardedAdAlertButtonType)
}

final class RewardedAdAlertCoordinator: NSObject, Coordinator {
    
    //MARK: - References
    weak var assistantsPromptEditParentCoordinator: AssistantsPromptEditCoordinator?
    weak var suggestionsParentCoordinator: SuggestionsCoordinator?
    private let navigationController: UINavigationController
    weak var delegate: RewardedAdAlertCoordinatorDelegate?
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Methods
    func start() {
        let rewardedAdAlertVC = RewardedAdAlertViewController()
        rewardedAdAlertVC.modalPresentationStyle = .custom
        rewardedAdAlertVC.transitioningDelegate = self
        rewardedAdAlertVC.rewardedAdAlertCoordinator = self
        navigationController.present(rewardedAdAlertVC, animated: true)
    }

}

extension RewardedAdAlertCoordinator {
    func didSelectButton(buttonType: RewardedAdAlertButtonType) {
        delegate?.rewardedAdAlertCoordinator(self, didSelectButton: buttonType)
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension RewardedAdAlertCoordinator: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CustomPresentationController(presentedViewController: presented, presenting: presenting, presentationHeightPercentage: 0.45)
    }
}
