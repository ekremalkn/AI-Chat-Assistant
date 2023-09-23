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
        
        let rightSettingBarButtonItem = UIBarButtonItem(customView: rightSettingButton)
        let rightHistoryBarButtonItem = UIBarButtonItem(customView: rightHistoryButton)
        
        navigationItem.rightBarButtonItems = [rightSettingBarButtonItem, rightHistoryBarButtonItem]
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .main
        navigationItem.backBarButtonItem = backBarButtonItem
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
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
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SuggestionsCollectionHeader.identifier, for: indexPath) as? SuggestionsCollectionHeader else {
                return .init()
            }
            
            header.configure(with: viewModel.homeCollectionViewSuggestions, selectedSuggestionCellIndexPath: viewModel.selectedSuggestionCategoryCellIndexPath)
            header.headerTextField.delegate = self
            header.delegate = self
            
            return header
            
        case UICollectionView.elementKindSectionFooter:
            break
        default:
            break
        }
        
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerHeight: CGFloat = 250
        let headerWidth: CGFloat = collectionView.frame.width
        
        return .init(width: headerWidth, height: headerHeight)
    }
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionsCollectionCell.identifier, for: indexPath) as? SuggestionsCollectionCell else {
            return .init()
        }
        
        let suggestions = viewModel.getSuggestions()
        let suggestion = suggestions[indexPath.item]
        cell.configure(with: suggestion)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectSuggestionAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 60) / 2
        let cellHeight = cellWidth * 1.25
        
        return .init(width: cellWidth, height: cellHeight)
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
    
}

//MARK: - SuggestionsCollectionHeader Delegate
extension SuggestionsViewController: SuggestionsCollectionHeaderDelegate {
    func suggestionsCollectionHeader(_ header: SuggestionsCollectionHeader, didSelectSuggestionCategory cellIndexPath: IndexPath) {
        viewModel.didSelectSuggestionCellInHeader(suggestionCellIndexPath: cellIndexPath)
    }
    
    
}

//MARK: - Header TextField Delegate
extension SuggestionsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        suggestionsCoordinator?.openChatVC()
        return false
    }
}

//MARK: - SuggestionsCoordinatorDelegate
extension SuggestionsViewController: SuggestionsCoordinatorDelegate {
    func suggestionsCoordinator(_ coordinator: SuggestionsCoordinator, didSelectModel model: GPTModel) {
        if let selectedSuggestion = viewModel.selectedSuggestion {
            suggestionsCoordinator?.openSuggestionsResponseVC(with: selectedSuggestion, selectedGPTModel: model)
        }
    }
    
    
}

