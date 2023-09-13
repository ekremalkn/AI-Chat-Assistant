//
//  AssistantsCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 13.09.2023.
//

import UIKit

final class AssistantsCollectionCell: UICollectionViewCell {
    static let identifier = "AssistantsCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var assistantsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
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
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }
    
    func configure(with assistant: Assistant) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            assistantsTitleLabel.text = assistant.assistantTitle
        }
    }
    
}

//MARK: - AddSubview / Constraints
extension AssistantsCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(assistantsTitleLabel)
        
        assistantsTitleLabel.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-8)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-20)
        }
    }
}

