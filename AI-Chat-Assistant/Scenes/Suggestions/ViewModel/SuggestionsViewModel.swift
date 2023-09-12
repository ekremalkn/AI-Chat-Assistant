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
}

final class SuggestionsViewModel {
    
    //MARK: - References
    weak var view: SuggestionsViewInterface?
    
    //MARK: - Variables
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
    
    var selectedSuggestionCellIndexPath: IndexPath = .init(item: 0, section: 0) {
        didSet {
            if !(selectedSuggestionCellIndexPath == oldValue) {
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
        homeCollectionViewSuggestions[selectedSuggestionCellIndexPath.item].suggestions.count
    }
    
    func getSuggestions() -> [Suggestion] {
        homeCollectionViewSuggestions[selectedSuggestionCellIndexPath.item].suggestions
    }
    
    func didSelectSuggestionCellInHeader(suggestionCellIndexPath: IndexPath) {
        self.selectedSuggestionCellIndexPath = suggestionCellIndexPath
    }
    
    
    
}
