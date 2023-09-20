//
//  PastChatView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 20.09.2023.
//

import UIKit
import RSKPlaceholderTextView

protocol PastChatViewDelegate: AnyObject {
    func pastChatView(_ view: PastChatView, continueChatButtonTapped button: UIButton)
    func pastChatView(_ view: PastChatView, shareChatButtonTapped button: UIButton)
    func pastChatView(_ view: PastChatView, sendButtonTapped button: UIButton)
}

final class PastChatView: UIView {

    //MARK: - Creating UI Elements
    lazy var chatCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SuggestionsChatCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SuggestionsChatCollectionHeader.identifier)
        collection.register(UserChatCollectionCell.self, forCellWithReuseIdentifier: UserChatCollectionCell.identifier)
        collection.register(AssistantChatCollectionCell.self, forCellWithReuseIdentifier: AssistantChatCollectionCell.identifier)
        collection.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
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
        textView.placeholder = "Write a message"
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
    
    
    private lazy var pastChatBottomButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = false
        return view
    }()
    
    private lazy var bottomButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var continueChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue Chat", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .main
        button.tintColor = .white
        button.addTarget(self, action: #selector(continueChatButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share Chat", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.tintColor = .white
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        button.addTarget(self, action: #selector(shareChatButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - References
    weak var delegate: PastChatViewDelegate?

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
        
        continueChatButton.layer.cornerRadius = 12
        continueChatButton.layer.masksToBounds = true
        
        shareChatButton.layer.cornerRadius = 12
        shareChatButton.layer.masksToBounds = true
    }

}

//MARK: - Bottom Views Visibility
extension PastChatView {
    func setMessageTextViewAndSendButtonVisibility(hide: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            messageTextView.isHidden = hide
            sendButton.isHidden = hide
            pastChatBottomButtonView.isHidden = !hide
        }
    }
    
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


//MARK: - Button Actions
extension PastChatView {
    @objc private func continueChatButtonTapped() {
        delegate?.pastChatView(self, continueChatButtonTapped: continueChatButton)
    }
    
    @objc private func shareChatButtonTapped() {
        delegate?.pastChatView(self, shareChatButtonTapped: shareChatButton)
    }
    
    @objc private func sendButtonTapped() {
        delegate?.pastChatView(self, sendButtonTapped: sendButton)
    }
}

//MARK: - AddSubview / Constraints
extension PastChatView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(chatCollectionView)
        addSubview(sendButton)
        addSubview(messageTextView)
        addSubview(pastChatBottomButtonView)
        pastChatBottomButtonView.addSubview(bottomButtonStackView)
        bottomButtonStackView.addArrangedSubview(shareChatButton)
        bottomButtonStackView.addArrangedSubview(continueChatButton)
        
        sendButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.centerY.equalTo(messageTextView.snp.centerY)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.trailing.equalTo(sendButton.snp.leading).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.greaterThanOrEqualTo(50)
        }
        
        pastChatBottomButtonView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        bottomButtonStackView.snp.makeConstraints { make in
            make.center.equalTo(pastChatBottomButtonView.snp.center)
            make.width.equalTo(pastChatBottomButtonView.snp.width)
            make.height.equalTo(pastChatBottomButtonView.snp.height)
        }
        
        chatCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(messageTextView.snp.top).offset(-10)
        }
        
    }
}

