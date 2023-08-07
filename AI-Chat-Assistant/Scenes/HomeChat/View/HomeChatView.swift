//
//  HomeChatView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit

final class HomeChatView: UIView {
    
    //MARK: - Creating UI Elements
    lazy var chatCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UserChatCollectionCell.self, forCellWithReuseIdentifier: UserChatCollectionCell.identifier)
        collection.register(AssistantChatCollectionCell.self, forCellWithReuseIdentifier: AssistantChatCollectionCell.identifier)
        collection.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18, weight: .medium)
        textView.textColor = .white
        textView.textContainerInset = .init(top: 14, left: 10, bottom: 14, right: 10)
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.backgroundColor = .textViewBackground
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(named: "chat_send"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .buttonBackground
        return button
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
        sendButton.layer.cornerRadius = 12
        sendButton.layer.masksToBounds = true
        
        messageTextView.layer.cornerRadius = 12
        messageTextView.layer.masksToBounds = true
    }
    
    
}

//MARK: - Setup UI
extension HomeChatView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(chatCollectionView)
        addSubview(sendButton)
        addSubview(messageTextView)
        
        sendButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.centerY.equalTo(messageTextView.snp.centerY)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.trailing.equalTo(sendButton.snp.leading).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.height.greaterThanOrEqualTo(50)
        }
        
        chatCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(messageTextView.snp.top).offset(-10)
        }
    }
}
