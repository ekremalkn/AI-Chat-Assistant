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
    private let selectedGPTModel: GPTModel
    
    //MARK: - Init Methods
    init(navigationController: UINavigationController, selectedSuggestion: Suggestion, selectedGPTModel: GPTModel) {
        self.navigationController = navigationController
        self.selectedSuggestion = selectedSuggestion
        self.selectedGPTModel = selectedGPTModel
    }

    //MARK: - Methods
    func start() {
        let openAIChatService: OpenAIChatService = NetworkService()
        let suggestionsResponseVM = SuggestionsResponseViewModel(openAIChatService: openAIChatService, selectedSuggestion: selectedSuggestion, selectedGPTModel: selectedGPTModel)
        let suggestionsResponseVC = SuggestionsResponseViewController(viewModel: suggestionsResponseVM)
        suggestionsResponseVC.suggestionsResponseCoordinator = self
        navigationController.pushViewController(suggestionsResponseVC, animated: true)
    }


}
