//
//  AssistantsPromptEditView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit

final class AssistantsPromptEditView: UIView {

    //MARK: - Creating UI Elements
    lazy var assistantsPromptEditCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.contentInset = .init(top: 0, left: 20, bottom: 20, right: 20)
        collection.backgroundColor = .vcBackground
        collection.register(AssistantsPromptEditCollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AssistantsPromptEditCollectionSectionHeader.identifier)
        collection.register(AssistantsPromptEditCollectionCell.self, forCellWithReuseIdentifier: AssistantsPromptEditCollectionCell.identifier)
        return collection
    }()
    
    private lazy var submitButton = SubmitButtonPromptEditScreen(type: .system)
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        submitButton.layer.cornerRadius = 8
        submitButton.layer.masksToBounds = true
    }

}

//MARK: - AddSubview / Constraints
extension AssistantsPromptEditView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(submitButton)

        addSubview(assistantsPromptEditCollectionView)

        submitButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        assistantsPromptEditCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(submitButton.snp.top).offset(-20)
        }
        
    }
}

