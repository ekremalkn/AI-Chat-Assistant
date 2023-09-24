//
//  AssistantsView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import UIKit

final class AssistantsView: UIView {

    //MARK: - Creating UI Elements
    lazy var assistantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AssistantsCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AssistantsCollectionHeader.identifier)
        collection.register(AssistantsCollectionCell.self, forCellWithReuseIdentifier: AssistantsCollectionCell.identifier)
        collection.contentInset = .init(top: 10, left: 20, bottom: 20, right: 20)
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
extension AssistantsView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(assistantsCollectionView)
        
        assistantsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
}

