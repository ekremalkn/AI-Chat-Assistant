//
//  SuggestionsCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 3.09.2023.
//

import UIKit

final class SuggestionsCollectionCell: UICollectionViewCell {
    static let identifier = "SuggestionsCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var suggestionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var suggestionNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private lazy var suggestionInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layou Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }

    
    func configure(with suggestion: Suggestion) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            suggestionImageView.image = .init(systemName: suggestion.suggestionImage)
            suggestionNameLabel.text = suggestion.suggestionName
            suggestionInfoLabel.text = suggestion.suggestionInfo
        }
    }

}

//MARK: - AddSubview / Constraints
extension SuggestionsCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(suggestionImageView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(suggestionNameLabel)
        labelStackView.addArrangedSubview(suggestionInfoLabel)
        
        suggestionImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.20)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(suggestionImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
        
    }
}

