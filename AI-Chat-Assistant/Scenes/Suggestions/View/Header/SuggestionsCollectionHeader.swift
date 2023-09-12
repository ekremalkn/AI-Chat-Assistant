//
//  SuggestionsCollectionHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

protocol SuggestionsCollectionHeaderDelegate: AnyObject {
    func suggestionsCollectionHeader(_ header: SuggestionsCollectionHeader, didSelectSuggestionCategory cellIndexPath: IndexPath)
}

final class SuggestionsCollectionHeader: UICollectionReusableView {
    static let identifier = "SuggestionsCollectionHeader"
    
    //MARK: - Creating UI Elements
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Type below to get answers \n Ask any open ended questions"
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var headerTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Type Here..."
        textField.textAlignment = .center
        textField.textColor = .white.withAlphaComponent(0.3)
        textField.backgroundColor = .textViewBackground
        return textField
    }()
    
    private lazy var suggestionLabel: UILabel = {
        let label = UILabel()
        label.text = "Suggestions"
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
    weak var delegate: SuggestionsCollectionHeaderDelegate?

    //MARK: - Variables
    var suggestionModels: [SuggestionModel] = []
    var selectedSuggestionCellIndexPath: IndexPath?
     
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerTextField.layer.cornerRadius = headerTextField.frame.height / 2
        headerTextField.layer.masksToBounds = true
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
extension SuggestionsCollectionHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        delegate?.suggestionsCollectionHeader(self, didSelectSuggestionCategory: indexPath)

        if let selectedSuggestionCellIndexPath, !(selectedSuggestionCellIndexPath == indexPath) {
            guard let cellToDeselect = collectionView.cellForItem(at: selectedSuggestionCellIndexPath) as? SuggestionCategoryCollectionCell else { return }
            cellToDeselect.deselectCell()
        }
        
        self.selectedSuggestionCellIndexPath = indexPath

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SuggestionCategoryCollectionCell else { return }
        cell.deselectCell()
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
extension SuggestionsCollectionHeader {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(headerTitleLabel)
        addSubview(headerTextField)
        addSubview(suggestionLabel)
        addSubview(suggestionCategoryCollectionView)
        
        headerTitleLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-60)
        }
        
        headerTextField.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(50)
        }
        
        suggestionLabel.snp.makeConstraints { make in
            make.top.equalTo(headerTextField.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        suggestionCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(suggestionLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(-20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

