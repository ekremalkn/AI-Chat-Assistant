//
//  HomeViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func configureViewController()
    
    func reloadSuggestions()
}

final class HomeViewController: UIViewController {
    
    //MARK: - References
    weak var homeCoordinator: HomeCoordinator?
    private let homeView = HomeView()
    private let viewModel: HomeViewModel
    
    //MARK: - Init Methods
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let leftTitleButton = UIButton()
        leftTitleButton.setImage(.init(named: "ChatGPT_24px"), for: .normal)
        leftTitleButton.tintColor = .main
        leftTitleButton.setTitle("Chat A.E", for: .normal)
        leftTitleButton.setTitleColor(.white, for: .normal)
        leftTitleButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        leftTitleButton.titleEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: -5)
        
        let leftTitleBarButton = UIBarButtonItem(customView: leftTitleButton)
        
        navigationItem.leftBarButtonItem = leftTitleBarButton
        
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        homeView.suggestionsCollectionView.delegate = self
        homeView.suggestionsCollectionView.dataSource = self
    }
    
    
    
}

//MARK: - Configure Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SuggestionsCollectionHeader.identifier, for: indexPath) as? SuggestionsCollectionHeader else {
                return .init()
            }
            
            header.configure(with: viewModel.homeCollectionViewSuggestions, selectedSuggestionCellIndexPath: viewModel.selectedSuggestionCellIndexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 60) / 2
        let cellHeight = cellWidth * 1.25
        
        return .init(width: cellWidth, height: cellHeight)
    }
}


//MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface {
    func configureViewController() {
        configureNavItems()
        setupDelegates()
    }
    
    func reloadSuggestions() {
        let collectionView = homeView.suggestionsCollectionView
        DispatchQueue.main.async {
                collectionView.reloadData()
        }
    }
    
}

//MARK: - SuggestionsCollectionHeader Delegate
extension HomeViewController: HomeCollectionHeaderDelegate {
    func suggestionsCollectionHeader(_ header: SuggestionsCollectionHeader, didSelectSuggestionCategory cellIndexPath: IndexPath) {
        viewModel.didSelectSuggestionCellInHeader(suggestionCellIndexPath: cellIndexPath)
    }
    
    
}

//MARK: - Header TextField Delegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        homeCoordinator?.openChatVC()
        return false
    }
}

