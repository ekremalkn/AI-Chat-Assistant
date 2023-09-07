//
//  HomeViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import Foundation

protocol  HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    
    func didSelectSuggestionCellInHeader(suggestionCellIndex: Int)
    func getSuggestions() -> [Suggestion]
}

final class HomeViewModel {
    
    //MARK: - References
    weak var view: HomeViewInterface?
    
    //MARK: - Variables
    var homeCollectionViewSuggestions: [SuggestionModel] = [
        .init(suggestionCategory: .education, suggestions: SuggestionProvider.educationSuggestions),
        .init(suggestionCategory: .fun, suggestions: SuggestionProvider.funSuggestions),
        .init(suggestionCategory: .beautyLifestyle, suggestions: SuggestionProvider.beautyLifestyleSuggestions),
        .init(suggestionCategory: .healthNutrition, suggestions: SuggestionProvider.healthNutritionSuggestions),
        .init(suggestionCategory: .astrology, suggestions: SuggestionProvider.astrologySuggestions),
        .init(suggestionCategory: .travel, suggestions: SuggestionProvider.travelSuggestions),
        .init(suggestionCategory: .businessMarketing, suggestions: SuggestionProvider.businessMarketing),
        .init(suggestionCategory: .social, suggestions: SuggestionProvider.socialSuggestions),
        .init(suggestionCategory: .socialMedia, suggestions: SuggestionProvider.socialMediaSuggestions),
        .init(suggestionCategory: .career, suggestions: SuggestionProvider.careerSuggestions),
        .init(suggestionCategory: .email, suggestions: SuggestionProvider.emailSuggestions),
        .init(suggestionCategory: .science, suggestions: SuggestionProvider.scienceSuggestions),
        .init(suggestionCategory: .creativeIdeas, suggestions: SuggestionProvider.creativeIdeaSuggestions),
    ]
    
    var selectedSuggestionCellIndex: Int = 0 {
        didSet {
            view?.reloadSuggestions()
        }
    }
    

    //MARK: - Init Methods
    init() {
        
    }


}

//MARK: - HomeViewModelInterface
extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func numberOfItems() -> Int {
        homeCollectionViewSuggestions[selectedSuggestionCellIndex].suggestions.count
    }
    
    func getSuggestions() -> [Suggestion] {
        homeCollectionViewSuggestions[selectedSuggestionCellIndex].suggestions
    }
    
    func didSelectSuggestionCellInHeader(suggestionCellIndex: Int) {
        self.selectedSuggestionCellIndex = suggestionCellIndex
    }
    
    
    
}
