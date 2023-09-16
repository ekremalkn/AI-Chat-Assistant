//
//  AssistantsResponseView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit

protocol AssistantsResponseViewDelegate: AnyObject {
    func assistantsResponseView(_ view: AssistantsResponseView, sendButtonTapped button: UIButton)
}

final class AssistantsResponseView: UIView {

    lazy var chatCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UserChatCollectionCell.self, forCellWithReuseIdentifier: UserChatCollectionCell.identifier)
        collection.register(AssistantChatCollectionCell.self, forCellWithReuseIdentifier: AssistantChatCollectionCell.identifier)
        collection.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var continuneChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue Chatting", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .buttonBackground
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.addTarget(self, action: #selector(continuneChatButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18, weight: .medium)
        textView.textColor = .white
        textView.textContainerInset = .init(top: 14, left: 10, bottom: 14, right: 10)
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.backgroundColor = .textViewBackground
        textView.isHidden = true
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(named: "chat_send"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .buttonBackground
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        button.isHidden = true
        return button
    }()
    
    //MARK: - References
    weak var delegate: AssistantsResponseViewDelegate?


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
        continuneChatButton.layer.cornerRadius = 12
        continuneChatButton.layer.masksToBounds = true
        
        sendButton.layer.cornerRadius = 12
        sendButton.layer.masksToBounds = true
        
        messageTextView.layer.cornerRadius = 12
        messageTextView.layer.masksToBounds = true
    }
}

//MARK: - Button Actions
extension AssistantsResponseView {
    @objc private func continuneChatButtonTapped() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            continuneChatButton.isHidden = true
            sendButton.isHidden = false
            messageTextView.isHidden = false
        }
    }
    
    @objc private func sendButtonTapped() {
        delegate?.assistantsResponseView(self, sendButtonTapped: sendButton)
    }
}

//MARK: - Send Button Visibility
extension AssistantsResponseView {
    func setSendButtonTouchability(_ isEnable: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch isEnable {
            case true:
                sendButton.isEnabled = true
            case false:
                sendButton.isEnabled = false
            }
        }
        
    }
}

//MARK: - AddSubview / Constraints
extension AssistantsResponseView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(chatCollectionView)
        addSubview(continuneChatButton)
        addSubview(sendButton)
        addSubview(messageTextView)
        
        
        continuneChatButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        chatCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(continuneChatButton.snp.top).offset(-20)
        }
                
        sendButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.trailing.equalTo(sendButton.snp.leading).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.centerY.equalTo(sendButton.snp.centerY)
            make.height.greaterThanOrEqualTo(50)
        }
    }
}
