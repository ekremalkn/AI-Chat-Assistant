//
//  SuggestionsResponseCoordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 17.09.2023.
//

import UIKit

final class SuggestionsResponseCoordinator: Coordinator {
    
    //MARK: - References
    weak var suggestionsParentCoordinator: SuggestionsCoordinator?
    private let navigationController: UINavigationController

    //MARK: - Variables
    var childCoordinators: [Coordinator] = []
    private let selectedSuggestion: Suggestion
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController, selectedSuggestion: Suggestion) {
        self.navigationController = navigationController
        self.selectedSuggestion = selectedSuggestion
    }

    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let suggestionsResponseVM = SuggestionsResponseViewModel(openAIChatService: openAIChatService, selectedSuggestion: selectedSuggestion)
        let suggestionsResponseVC = SuggestionsResponseViewController(viewModel: suggestionsResponseVM)
        suggestionsResponseVC.suggestionsResponseCoordinator = self
        navigationController.pushViewController(suggestionsResponseVC, animated: true)
    }


}
