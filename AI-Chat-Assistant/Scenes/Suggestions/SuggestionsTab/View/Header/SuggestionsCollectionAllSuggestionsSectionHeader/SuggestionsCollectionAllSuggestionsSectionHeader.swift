//
//  SuggestionsCollectionSuggestionsSectionHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

protocol SuggestionsCollectionAllSuggestionsSectionHeaderDelegate: AnyObject {
    func suggestionsCollectionAllSuggestionsSectionHeader(_ header: SuggestionsCollectionAllSuggestionsSectionHeader, didSelectSuggestionCategory cellIndexPath: IndexPath)
}

final class SuggestionsCollectionAllSuggestionsSectionHeader: UICollectionReusableView {
    static let identifier = "SuggestionsCollectionAllSuggestionsSectionHeader"
    
    //MARK: - Creating UI Elements
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Suggestions".localized()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var suggestionCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SuggestionCategoryCollectionCell.self, forCellWithReuseIdentifier: SuggestionCategoryCollectionCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        return collection
    }()
    
    //MARK: - References
    weak var delegate: SuggestionsCollectionAllSuggestionsSectionHeaderDelegate?
    
    //MARK: - Variables
    var suggestionModels: [SuggestionModel] = []
    var selectedSuggestionCellIndexPath: IndexPath?
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with suggestionModels: [SuggestionModel], selectedSuggestionCellIndexPath: IndexPath) {
        self.suggestionModels = suggestionModels
        self.selectedSuggestionCellIndexPath = selectedSuggestionCellIndexPath
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        suggestionCategoryCollectionView.delegate = self
        suggestionCategoryCollectionView.dataSource = self
    }
    
}

//MARK: - Configure ColelctionView
extension SuggestionsCollectionAllSuggestionsSectionHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        suggestionModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionCategoryCollectionCell.identifier, for: indexPath) as? SuggestionCategoryCollectionCell else {
            return .init()
        }
        
        if let selectedSuggestionCellIndexPath, selectedSuggestionCellIndexPath == indexPath {
            cell.selectCell()
        } else {
            cell.deselectCell()
        }
        
        let suggestion = suggestionModels[indexPath.item]
        cell.configure(with: suggestion.suggestionCategory)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SuggestionCategoryCollectionCell else { return }
        cell.selectCell()
        delegate?.suggestionsCollectionAllSuggestionsSectionHeader(self, didSelectSuggestionCategory: indexPath)
        
        if let selectedSuggestionCellIndexPath, !(selectedSuggestionCellIndexPath == indexPath) {
            guard let cellToDeselect = collectionView.cellForItem(at: selectedSuggestionCellIndexPath) as? SuggestionCategoryCollectionCell else { return }
            cellToDeselect.deselectCell()
        }
        
        self.selectedSuggestionCellIndexPath = indexPath
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: CGFloat = collectionView.frame.height
        
        let suggestionTitle = suggestionModels[indexPath.item].suggestionCategory.suggestionCategoryTitle
        let suggestionTitleWidth = suggestionTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]).width
        
        let cellWidth: CGFloat = suggestionTitleWidth + (2 * 15)
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
    
    
}


//MARK: - AddSubview / Constraints
extension SuggestionsCollectionAllSuggestionsSectionHeader {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(sectionTitleLabel)
        addSubview(suggestionCategoryCollectionView)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(20)
        }
        
        suggestionCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(-20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

