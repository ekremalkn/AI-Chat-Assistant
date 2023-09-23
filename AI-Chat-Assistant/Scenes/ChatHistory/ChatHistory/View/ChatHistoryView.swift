//
//  ChatHistoryView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import UIKit

final class ChatHistoryView: UIView {

    //MARK: - Creating UI Elements
    lazy var chatHistoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ChatHistoryCollectionEmptyHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ChatHistoryCollectionEmptyHeader.identifier)
        collection.register(ChatHistoryCollectionCell.self, forCellWithReuseIdentifier: ChatHistoryCollectionCell.identifier)
        collection.backgroundColor = .clear
        collection.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
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
extension ChatHistoryView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(chatHistoryCollectionView)
        
        chatHistoryCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
}

