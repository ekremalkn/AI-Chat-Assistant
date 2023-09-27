//
//  SettingsView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import UIKit

final class SettingsView: UIView {

    //MARK: - Creating UI Elements
    lazy var settingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SubscribeCollectionViewCell.self, forCellWithReuseIdentifier: SubscribeCollectionViewCell.identifier)
        collection.register(SettingsCollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingsCollectionSectionHeader.identifier)
        collection.register(SettingsCollectionCell.self, forCellWithReuseIdentifier: SettingsCollectionCell.identifier)
        collection.register(SettingsCollectionFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SettingsCollectionFooter.identifier)
        collection.contentInset = .init(top: 10, left: 20, bottom: 40, right: 20)
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
extension SettingsView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(settingsCollectionView)
        
        settingsCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}

