//
//  HomeViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import Foundation
import Reachability

protocol  SuggestionsViewModelInterface {
    var view: SuggestionsViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func numberOfSelectedCategorySuggestions(section: Int) -> Int
    
    func didSelectSuggestionCellInHeader(suggestionCellIndexPath: IndexPath)
    func getSuggestionsIn(section: Int) -> [Suggestion]
    
    func didSelectSuggestionFromAllSuggestionsHeaderAt(indexPath: IndexPath)
    func didSelectSuggestionFromMostUsedSuggestionsHeaderAt(indexPath: IndexPath)
}

final class SuggestionsViewModel {

    //MARK: - References
    weak var view: SuggestionsViewInterface?
    
    //MARK: - Variables
    let reachability = try! Reachability()
    
    var currentModel: GPTModel = .gpt3_5Turbo
    var collectionViewSections: [SuggestionSection] = [
        .init(suggestionSectionCategory: .mostUsedSuggestions, suggestions: [
            .init(suggestionCategory: .mostUsed, suggestions: SuggestionProvider.mostUsedSuggestions)
        ]),
        .init(suggestionSectionCategory: .allSuggestions, suggestions: [
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
        ])
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
    
    func viewWillAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    func numberOfSelectedCategorySuggestions(section: Int) -> Int {
        collectionViewSections[section].suggestions[selectedSuggestionCategoryCellIndexPath.item].suggestions.count
    }
    
    func getSuggestionsIn(section: Int) -> [Suggestion] {
        collectionViewSections[section].suggestions[selectedSuggestionCategoryCellIndexPath.item].suggestions
    }
    
    func didSelectSuggestionCellInHeader(suggestionCellIndexPath: IndexPath) {
        self.selectedSuggestionCategoryCellIndexPath = suggestionCellIndexPath
    }
    
    func didSelectSuggestionFromAllSuggestionsHeaderAt(indexPath: IndexPath) {
        let selectedSuggestion = collectionViewSections[indexPath.section].suggestions[selectedSuggestionCategoryCellIndexPath.item].suggestions[indexPath.item]
        
        self.selectedSuggestion = selectedSuggestion
        
        view?.openModelSelectToSelectGPTModel()
    }
    
    func didSelectSuggestionFromMostUsedSuggestionsHeaderAt(indexPath: IndexPath) {
        let selectedSuggestion = collectionViewSections[indexPath.section].suggestions[0].suggestions[indexPath.item]
        
        self.selectedSuggestion = selectedSuggestion
        
        view?.openModelSelectToSelectGPTModel()
    }
    
    
}

//MARK: - Reachability Methods
extension SuggestionsViewModel {
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            view?.deleteNoInternetView()
        case .cellular:
            print("Reachable via Cellular")
            view?.deleteNoInternetView()
        case .unavailable:
            print("Network not reachable")
            view?.showNoInternetView()
        }
    }
}

