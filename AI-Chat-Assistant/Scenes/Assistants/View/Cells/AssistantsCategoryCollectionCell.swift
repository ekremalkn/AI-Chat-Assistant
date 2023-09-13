//
//  AssistantsCategoryCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 13.09.2023.
//

import UIKit

final class AssistantsCategoryCollectionCell: UICollectionViewCell {
    static let identifier = "AssistantsCategoryCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var assistantCategoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func configure(assistant: AssistantsModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            assistantCategoryTitleLabel.text = assistant.assistantCategory.assistantCategoryTitle
        }
    }
    
    
}

extension AssistantsCategoryCollectionCell {
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
extension AssistantsCategoryCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(assistantCategoryTitleLabel)
        
        assistantCategoryTitleLabel.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-5)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-10)
        }
    }
}

