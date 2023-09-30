//
//  SuggestionsCollectionMostUsedSuggestionsSectionHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import UIKit

protocol SuggestionsCollectionMostUsedSuggestionsSectionHeaderDelegate: AnyObject {
    func suggestionsCollectionMostUsedSuggestionsSectionHeader(_ header: SuggestionsCollectionMostUsedSuggestionsSectionHeader, didSelectSuggestionAt indexPath: IndexPath)
}

final class SuggestionsCollectionMostUsedSuggestionsSectionHeader: UICollectionReusableView {
    static let identifier = "SuggestionsCollectionMostUsedSuggestionsSectionHeader"
    
    //MARK: - Creating UI Elements
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Most Used".localized()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var mostUsedSuggestionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MostUsedSuggestionsCollectionCell.self, forCellWithReuseIdentifier: MostUsedSuggestionsCollectionCell.identifier)
        collection.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    //MARK: - References
    weak var delegate: SuggestionsCollectionMostUsedSuggestionsSectionHeaderDelegate?

    //MARK: - Variables
    var headerSectionIndex: Int?
    
    private var mostUsedSuggestions: [Suggestion] = []
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        mostUsedSuggestionsCollectionView.delegate = self
        mostUsedSuggestionsCollectionView.dataSource = self
    }
    
    func configure(with suggestions: [Suggestion], suggestionCategory: SuggestionCategory, headerSectionIndex: Int) {
        self.mostUsedSuggestions = suggestions
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            sectionTitleLabel.text = suggestionCategory.suggestionCategoryTitle
            self.headerSectionIndex = headerSectionIndex
        }
    }
    
}

//MARK: - Configure CollectionView
extension SuggestionsCollectionMostUsedSuggestionsSectionHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mostUsedSuggestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MostUsedSuggestionsCollectionCell.identifier, for: indexPath) as? MostUsedSuggestionsCollectionCell else {
            return .init()
        }
        
        let suggestion = mostUsedSuggestions[indexPath.item]
        cell.configure(with: suggestion)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let headerSectionIndex {
            let selectedIndexPath = IndexPath(item: indexPath.item, section: headerSectionIndex)
            delegate?.suggestionsCollectionMostUsedSuggestionsSectionHeader(self, didSelectSuggestionAt: selectedIndexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - 60) / 3
        let cellHeight: CGFloat = collectionView.frame.height
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
    
    
}


//MARK: - AddSubview / Constraints
extension SuggestionsCollectionMostUsedSuggestionsSectionHeader {
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(sectionTitleLabel)
        addSubview(mostUsedSuggestionsCollectionView)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(20)
        }
        
        mostUsedSuggestionsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(-20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

