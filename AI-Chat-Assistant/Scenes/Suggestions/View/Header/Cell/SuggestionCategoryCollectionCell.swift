//
//  SuggestionCategoryCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class SuggestionCategoryCollectionCell: UICollectionViewCell {
    static let identifier = "SuggestionCategoryCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var suggestionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    //MARK: - Variables

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
        self.layer.borderWidth = 1
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func configure(with suggestion: SuggestionCategory) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            suggestionLabel.text =  suggestion.suggestionCategoryTitle
        }
    }
    
}

//MARK: - Animations
extension SuggestionCategoryCollectionCell {
    func selectCell() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func deselectCell() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            layer.borderColor = UIColor.clear.cgColor
        }
    }
}


//MARK: - AddSubview / Constraints
extension SuggestionCategoryCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(suggestionLabel)
        
        suggestionLabel.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-15)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-15)
        }
    }
}

