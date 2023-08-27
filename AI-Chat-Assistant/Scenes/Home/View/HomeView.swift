//
//  HomeView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class HomeView: UIView {

    //MARK: - Creating UI Elements
    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HomeCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeader.identifier)
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
        addSubview(homeCollectionView)
        
        homeCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
}

