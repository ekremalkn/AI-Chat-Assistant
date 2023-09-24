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
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var chatSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var senderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var chatCreationDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white.withAlphaComponent(0.6)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var firstSenderView = ChatHistorySenderView()
    private lazy var secondSenderView = ChatHistorySenderView()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subview
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
    }

    
    func configure(with chatHistoryItem: ChatHistoryItem) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            chatTitleLabel.text = chatHistoryItem.chatTitleText
            chatSubTitleLabel.text = chatHistoryItem.chatSubTitleText
            chatCreationDateLabel.text = chatHistoryItem.chatCreationDate?.localizedStringWithFormat("dd/MM/yyyy HH:mm")
            
            if chatHistoryItem.chatMessages?.count ?? 1 >= 2 {
                if let chatMessages = chatHistoryItem.chatMessages?.allObjects as? [ChatMessageItem] {
                    let sortedChatMessage = chatMessages.sorted { ($0.createAt ?? Date()) < ($1.createAt ?? Date()) }
                    
                    let firstSenderMessage = sortedChatMessage[0]
                    firstSenderView.configure(chatMessageItem: firstSenderMessage)
                    
                    let secondSenderMessage = sortedChatMessage[1]
                    secondSenderView.configure(chatMessageItem: secondSenderMessage)
                }
                
            }
        }
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
        senderStackView.addArrangedSubview(firstSenderView)
        senderStackView.addArrangedSubview(secondSenderView)
        
        addSubview(chatCreationDateLabel)
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        senderStackView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.lessThanOrEqualTo(chatCreationDateLabel.snp.top).offset(-5)
        }
        
        chatCreationDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.leading.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.height.equalTo(20)
        }


    }
}

