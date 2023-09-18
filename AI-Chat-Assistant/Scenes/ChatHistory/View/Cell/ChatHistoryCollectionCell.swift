//
//  ChatHistoryCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import UIKit

final class ChatHistoryCollectionCell: UICollectionViewCell {
    static let identifier = "ChatHistoryCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var chatTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var chatSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var senderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var userSenderView = ChatHistorySenderView()
    private lazy var assistantSenderView = ChatHistorySenderView()
    
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
extension ChatHistoryCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(chatTitleLabel)
        labelStackView.addArrangedSubview(chatSubTitleLabel)
        addSubview(senderStackView)
        senderStackView.addArrangedSubview(userSenderView)
        senderStackView.addArrangedSubview(assistantSenderView)
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.35)
        }
        
        senderStackView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

