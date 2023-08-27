//
//  HomeCollectionHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class HomeCollectionHeader: UICollectionReusableView {
    static let identifier = "HomeCollectionHeader"
    
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
    
    lazy var suggestionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SuggestionsCollectionCell.self, forCellWithReuseIdentifier: SuggestionsCollectionCell.identifier)
        collection.backgroundColor = .cellBackground
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerTextField.layer.cornerRadius = headerTextField.frame.height / 2
        headerTextField.layer.masksToBounds = true
    }

    
    
}

//MARK: - AddSubview / Constraints
extension HomeCollectionHeader {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(headerTitleLabel)
        addSubview(headerTextField)
        addSubview(suggestionLabel)
        addSubview(suggestionsCollectionView)
        
        headerTitleLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-60)
        }
        
        headerTextField.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        suggestionLabel.snp.makeConstraints { make in
            make.top.equalTo(headerTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(headerTextField)
        }
        
        suggestionsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(suggestionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(headerTextField)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(40)
        }
    }
}

