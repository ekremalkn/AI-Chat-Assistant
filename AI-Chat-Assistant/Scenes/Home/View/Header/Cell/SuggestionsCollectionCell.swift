//
//  SuggestionsCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class SuggestionsCollectionCell: UICollectionViewCell {
    static let identifier = "SuggestionsCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var suggestionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
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
    
    func configure(with suggestion: String) {
        suggestionLabel.text = "🚀 suggestion"
    }
    
}

//MARK: - AddSubview / Constraints
extension SuggestionsCollectionCell {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(suggestionLabel)
        
        suggestionLabel.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-10)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-10)
        }
    }
}

