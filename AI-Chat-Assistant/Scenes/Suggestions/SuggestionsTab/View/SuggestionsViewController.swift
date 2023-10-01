//
//  SuggestionsViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

protocol SuggestionsViewInterface: AnyObject {
    func configureViewController()
    
    func reloadSuggestions()
    
    func openModelSelectToSelectGPTModel()
    
    func showNoInternetView()
    func deleteNoInternetView()
    
    func openPaywall()
}

final class SuggestionsViewController: UIViewController {
    
    //MARK: - References
    weak var suggestionsCoordinator: SuggestionsCoordinator?
    private let suggestionsView = SuggestionsView()
    private let viewModel: SuggestionsViewModel
    
    //MARK: - Init Methods
    init(viewModel: SuggestionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = suggestionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        navigationController?.tabBarController?.tabBar.isTranslucent = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let leftTitleButton = NavigationLeftAppTitleButton()
        
        let leftTitleBarButton = UIBarButtonItem(customView: leftTitleButton)
        
        navigationItem.leftBarButtonItem = leftTitleBarButton
        
        let rightSettingButton = UIButton(type: .system)
        rightSettingButton.setImage(.init(named: "chat_setting"), for: .normal)
        rightSettingButton.tintColor = .white
        rightSettingButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        let rightHistoryButton = UIButton(type: .system)
        rightHistoryButton.setImage(.init(named: "chat_history"), for: .normal)
        rightHistoryButton.tintColor = .white
        rightHistoryButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .main
        navigationItem.backBarButtonItem = backBarButtonItem
        
        let rightSettingBarButtonItem = UIBarButtonItem(customView: rightSettingButton)
        let rightHistoryBarButtonItem = UIBarButtonItem(customView: rightHistoryButton)
        
        navigationItem.rightBarButtonItems = [rightSettingBarButtonItem, rightHistoryBarButtonItem]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .vcBackground
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        suggestionsCoordinator?.delegate = self
        
        suggestionsView.suggestionsCollectionView.delegate = self
        suggestionsView.suggestionsCollectionView.dataSource = self
    }
    
    
    
}

//MARK: - Button Actions
extension SuggestionsViewController {
    @objc private func historyButtonTapped() {
        suggestionsCoordinator?.openChatHistoryVC()
    }
    
    @objc private func settingsButtonTapped() {
        suggestionsCoordinator?.openSettingsVC()
    }
}

//MARK: - Configure Collection View
extension SuggestionsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Header
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.collectionViewSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionCategory = viewModel.collectionViewSections[indexPath.section].suggestionSectionCategory
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch sectionCategory {
            case .mostUsedSuggestions:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SuggestionsCollectionMostUsedSuggestionsSectionHeader.identifier, for: indexPath) as? SuggestionsCollectionMostUsedSuggestionsSectionHeader else {
                    return .init()
                }
                
                if let suggestionModel = viewModel.collectionViewSections[indexPath.section].suggestions.first {
                    let mostUsedSuggestions = suggestionModel.suggestions
                    let suggestionCategory = suggestionModel.suggestionCategory
                    
                    header.configure(with: mostUsedSuggestions, suggestionCategory: suggestionCategory, headerSectionIndex: indexPath.section)
                }
                
                header.delegate = self
                
                return header
            case .allSuggestions:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SuggestionsCollectionAllSuggestionsSectionHeader.identifier, for: indexPath) as? SuggestionsCollectionAllSuggestionsSectionHeader else {
                    return .init()
                }
                
                let categorySuggestions = viewModel.collectionViewSections[indexPath.section].suggestions
                
                header.configure(with: categorySuggestions, selectedSuggestionCellIndexPath: viewModel.selectedSuggestionCategoryCellIndexPath)
                header.delegate = self
                
                return header
            }
            
            
        case UICollectionView.elementKindSectionFooter:
            return .init()
        default:
            return .init()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionCategory = viewModel.collectionViewSections[section].suggestionSectionCategory
        let headerWidth: CGFloat = collectionView.frame.width
        
        switch sectionCategory {
        case .mostUsedSuggestions:
            let headerHeight: CGFloat = 170
            
            return .init(width: headerWidth, height: headerHeight)
        case .allSuggestions:
            let headerHeight: CGFloat = 100
            
            return .init(width: headerWidth, height: headerHeight)
        }
        
    }
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionCategory = viewModel.collectionViewSections[section].suggestionSectionCategory
        
        switch sectionCategory {
        case .mostUsedSuggestions:
            return 0
        case .allSuggestions:
            return viewModel.numberOfSelectedCategorySuggestions(section: section)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionCategory = viewModel.collectionViewSections[indexPath.section].suggestionSectionCategory
        
        switch sectionCategory {
        case .mostUsedSuggestions:
            return .init()
        case .allSuggestions:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionsCollectionCell.identifier, for: indexPath) as? SuggestionsCollectionCell else {
                return .init()
            }
            
            let suggestions = viewModel.getSuggestionsIn(section: indexPath.section)
            let suggestion = suggestions[indexPath.item]
            cell.configure(with: suggestion)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionCategory = viewModel.collectionViewSections[indexPath.section].suggestionSectionCategory
        
        switch sectionCategory {
        case .mostUsedSuggestions:
            break
        case .allSuggestions:
            viewModel.didSelectSuggestionFromAllSuggestionsHeaderAt(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionCategory = viewModel.collectionViewSections[indexPath.section].suggestionSectionCategory
        
        switch sectionCategory {
        case .mostUsedSuggestions:
            return .init()
        case .allSuggestions:
            let cellWidth = (collectionView.frame.width - 60) / 2
            let cellHeight = cellWidth * 1.25
            
            return .init(width: cellWidth, height: cellHeight)
        }
        
    }
}


//MARK: - SuggestionsViewInterface
extension SuggestionsViewController: SuggestionsViewInterface {
    func configureViewController() {
        configureNavItems()
        setupDelegates()
    }
    
    func reloadSuggestions() {
        let collectionView = suggestionsView.suggestionsCollectionView
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
    
    func openModelSelectToSelectGPTModel() {
        suggestionsCoordinator?.openModelSelectVC(with: viewModel.currentModel)
    }
    
    func showNoInternetView() {
        addNoInternetView()
    }
    
    func deleteNoInternetView() {
        removeNoInternetView()
    }
    
    func openPaywall() {
        suggestionsCoordinator?.openPaywall()
    }
    
}

//MARK: - SuggestionsCollectionHeader Delegate
extension SuggestionsViewController: SuggestionsCollectionAllSuggestionsSectionHeaderDelegate {
    func suggestionsCollectionAllSuggestionsSectionHeader(_ header: SuggestionsCollectionAllSuggestionsSectionHeader, didSelectSuggestionCategory cellIndexPath: IndexPath) {
        viewModel.didSelectSuggestionCellInHeader(suggestionCellIndexPath: cellIndexPath)
    }
}

//MARK: - SuggestionsCollectionMostUsedSuggestionsSectionHeaderDelegate
extension SuggestionsViewController: SuggestionsCollectionMostUsedSuggestionsSectionHeaderDelegate {
    func suggestionsCollectionMostUsedSuggestionsSectionHeader(_ header: SuggestionsCollectionMostUsedSuggestionsSectionHeader, didSelectSuggestionAt indexPath: IndexPath) {
        viewModel.didSelectSuggestionFromMostUsedSuggestionsHeaderAt(indexPath: indexPath)
    }
    
}

//MARK: - SuggestionsCoordinatorDelegate
extension SuggestionsViewController: SuggestionsCoordinatorDelegate {
    func suggestionsCoordinator(_ coordinator: SuggestionsCoordinator, didSelectModel model: GPTModel) {
        
        switch MessageManager.shared.getUserMessageStatus() {
            
        case .noMessageLimit:
            suggestionsCoordinator?.openPaywall()
            
        case .canSendMessage(let isSubscribed):
            if isSubscribed {
                if let selectedSuggestion = viewModel.selectedSuggestion {
                    suggestionsCoordinator?.openSuggestionsResponseVC(with: selectedSuggestion, selectedGPTModel: model)
                }
            } else {
                if model == .gpt4 {
                    suggestionsCoordinator?.openPaywall()
                } else {
                    if let selectedSuggestion = viewModel.selectedSuggestion {
                        suggestionsCoordinator?.openSuggestionsResponseVC(with: selectedSuggestion, selectedGPTModel: model)
                    }
                }
            }
            
        }
        
    }
    
    
}

