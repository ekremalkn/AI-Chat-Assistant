//
//  SettingsCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import UIKit

final class SettingsCoordinator: Coordinator {
 
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
        
    }

    


}
