//
//  AssistantsResponseView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit
import RSKPlaceholderTextView

protocol AssistantsResponseViewDelegate: AnyObject {
    func assistantsResponseView(_ view: AssistantsResponseView, sendButtonTapped button: UIButton)
    func assistantsResponseView(_ view: AssistantsResponseView, getPremiumButtonTapped button: UIButton)
}

final class AssistantsResponseView: UIView {
    
    lazy var chatCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ChatCollectionModelHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ChatCollectionModelHeader.identifier)
        collection.register(UserChatCollectionCell.self, forCellWithReuseIdentifier: UserChatCollectionCell.identifier)
        collection.register(AssistantChatCollectionCell.self, forCellWithReuseIdentifier: AssistantChatCollectionCell.identifier)
        collection.contentInset = .init(top: 10, left: 0, bottom: 20, right: 0)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var continuneChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue Chatting".localized(), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .main
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.addTarget(self, action: #selector(continuneChatButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var messageTextView: RSKPlaceholderTextView = {
        let textView = RSKPlaceholderTextView()
        textView.font = .systemFont(ofSize: 18, weight: .medium)
        textView.textColor = .white
        textView.textContainerInset = .init(top: 14, left: 10, bottom: 14, right: 10)
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.backgroundColor = .textViewBackground
        textView.isHidden = true
        textView.autocorrectionType = .no
        textView.placeholder = NSString(string: "Write a message".localized())
        textView.placeholderColor = .white.withAlphaComponent(0.6)
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(named: "chat_send"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .main
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        button.isHidden = true
        return button
    }()
    
    private lazy var freeMessageCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var freeMessageCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var getPremiumTextButton: GetPremiumTextButton = {
        let button = GetPremiumTextButton(type: .system)
        button.addTarget(self, action: #selector(getPremiumButtonTapped), for: .touchUpInside)
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
    
    func updateFreeMessageCountLabel() {
        if RevenueCatManager.shared.isSubscribe {
            freeMessageCountStackView.removeFromSuperview()
        } else {
            let freeMessageCount = MessageManager.shared.freeMessageCount
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                freeMessageCountLabel.text = "You have".localized() + " \(freeMessageCount) " + "free message left.".localized()
            }
        }
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
    
    @objc private func getPremiumButtonTapped() {
        delegate?.assistantsResponseView(self, getPremiumButtonTapped: getPremiumTextButton)
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
        addSubview(freeMessageCountStackView)
        freeMessageCountStackView.addArrangedSubview(freeMessageCountLabel)
        freeMessageCountStackView.addArrangedSubview(getPremiumTextButton)
        
        continuneChatButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        chatCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(continuneChatButton.snp.top).offset(-25)
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
        
        freeMessageCountStackView.snp.makeConstraints { make in
            make.bottom.equalTo(messageTextView.snp.top).offset(-5)
            make.leading.equalTo(messageTextView.snp.leading).offset(6)
            make.trailing.lessThanOrEqualTo(sendButton.snp.trailing).offset(-6)
            make.height.equalTo(20)
        }
    }
}
