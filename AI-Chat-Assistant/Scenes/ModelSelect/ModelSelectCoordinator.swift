//
//  ModelSelectCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import Foundation
import UIKit

protocol ModelSelectCoordinatorDelegate: AnyObject {
    func modelSelectCoordinator(_ coordinator: ModelSelectCoordinator, didSelectModel model: GPTModel)
}

final class ModelSelectCoordinator: NSObject, Coordinator {
    
    //MARK: - References
    weak var homeChatParentCoordinator: ChatCoordinator?
    private let navigationController: UINavigationController
    weak var delegate: ModelSelectCoordinatorDelegate?
    
    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    private let openedModel: GPTModel
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController, model: GPTModel) {
        self.navigationController = navigationController
        self.openedModel = model
    }

    //MARK: - Methods
    func start() {
        let modelSelectVM = ModelSelectViewModel(model: openedModel)
        let modelSelectVC = ModelSelectViewController(viewModel: modelSelectVM)
        modelSelectVC.modalPresentationStyle = .custom
        modelSelectVC.transitioningDelegate = self
        modelSelectVC.modelSelectCoordinator = self
        navigationController.present(modelSelectVC, animated: true)
    }


}

//MARK: - ModelSelectCoordinator Methods
extension ModelSelectCoordinator {
    func didSelectModel(model: GPTModel) {
        delegate?.modelSelectCoordinator(self, didSelectModel: model)
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension ModelSelectCoordinator: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CustomPresentationController(presentedViewController: presented, presenting: presenting, presentationHeightPercentage: 0.7)
    }
}

