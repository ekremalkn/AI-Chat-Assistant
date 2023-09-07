//
//  HomeView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class HomeView: UIView {

    //MARK: - Creating UI Elements
    lazy var suggestionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SuggestionsCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SuggestionsCollectionHeader.identifier)
        collection.register(SuggestionsCollectionCell.self, forCellWithReuseIdentifier: SuggestionsCollectionCell.identifier)
        collection.contentInset = .init(top: 0, left: 20, bottom: 20, right: 20)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()

    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

//MARK: - AddSubview / Constraints
extension HomeView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(suggestionsCollectionView)
        
        suggestionsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
}

