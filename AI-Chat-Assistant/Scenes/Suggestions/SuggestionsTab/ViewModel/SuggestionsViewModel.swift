//
//  HomeViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import Foundation

protocol  SuggestionsViewModelInterface {
    var view: SuggestionsViewInterface? { get set }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    
    func didSelectSuggestionCellInHeader(suggestionCellIndexPath: IndexPath)
    func getSuggestions() -> [Suggestion]
    
    func didSelectSuggestionAt(indexPath: IndexPath)
}

final class SuggestionsViewModel {
    
    //MARK: - References
    weak var view: SuggestionsViewInterface?
    
    //MARK: - Variables
    var currentModel: GPTModel = .gpt3_5Turbo
    var homeCollectionViewSuggestions: [SuggestionModel] = [
        .init(suggestionCategory: .education, suggestions: SuggestionProvider.educationSuggestions),
        .init(suggestionCategory: .fun, suggestions: SuggestionProvider.funSuggestions),
        .init(suggestionCategory: .beautyLifestyle, suggestions: SuggestionProvider.beautyLifestyleSuggestions),
        .init(suggestionCategory: .healthNutrition, suggestions: SuggestionProvider.healthNutritionSuggestions),
        .init(suggestionCategory: .astrology, suggestions: SuggestionProvider.astrologySuggestions),
        .init(suggestionCategory: .travel, suggestions: SuggestionProvider.travelSuggestions),
        .init(suggestionCategory: .businessMarketing, suggestions: SuggestionProvider.businessMarketing),
        .init(suggestionCategory: .fashion, suggestions: SuggestionProvider.fashionSuggestions),
        .init(suggestionCategory: .socialMedia, suggestions: SuggestionProvider.socialMediaSuggestions),
        .init(suggestionCategory: .career, suggestions: SuggestionProvider.careerSuggestions),
        .init(suggestionCategory: .email, suggestions: SuggestionProvider.emailSuggestions),
        .init(suggestionCategory: .creativeIdeas, suggestions: SuggestionProvider.creativeIdeaSuggestions),
    ]
    
    var selectedSuggestion: Suggestion?
    
    var selectedSuggestionCategoryCellIndexPath: IndexPath = .init(item: 0, section: 0) {
        didSet {
            if !(selectedSuggestionCategoryCellIndexPath == oldValue) {
                view?.reloadSuggestions()
            }
        }
    }
    
    
    //MARK: - Init Methods
    init() {
        
    }
    
    
}

//MARK: - SuggestionsViewModelInterface
extension SuggestionsViewModel: SuggestionsViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func numberOfItems() -> Int {
        homeCollectionViewSuggestions[selectedSuggestionCategoryCellIndexPath.item].suggestions.count
    }
    
    func getSuggestions() -> [Suggestion] {
        homeCollectionViewSuggestions[selectedSuggestionCategoryCellIndexPath.item].suggestions
    }
    
    func didSelectSuggestionCellInHeader(suggestionCellIndexPath: IndexPath) {
        self.selectedSuggestionCategoryCellIndexPath = suggestionCellIndexPath
    }
    
    func didSelectSuggestionAt(indexPath: IndexPath) {
        let selectedSuggestion = homeCollectionViewSuggestions[selectedSuggestionCategoryCellIndexPath.item].suggestions[indexPath.item]
        
        self.selectedSuggestion = selectedSuggestion
        
        view?.openModelSelectToSelectGPTModel()
    }
    
    
}
