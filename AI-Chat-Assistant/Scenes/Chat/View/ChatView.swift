//
//  ChatView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import GoogleMobileAds
import UIKit
import RSKPlaceholderTextView

protocol ChatViewDelegate: AnyObject {
    func chatView(_ view: ChatView, sendButtonTapped button: UIButton)
    func chatView(_ view: ChatView, getPremiumButtonTapped button: UIButton)
}

final class ChatView: UIView {
    
    //MARK: - Creating UI Elements
    lazy var chatCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ChatCollectionModelHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ChatCollectionModelHeader.identifier)
        collection.register(ChatCollectionModelSelectCell.self, forCellWithReuseIdentifier: ChatCollectionModelSelectCell.identifier)
        collection.register(UserChatCollectionCell.self, forCellWithReuseIdentifier: UserChatCollectionCell.identifier)
        collection.register(AssistantChatCollectionCell.self, forCellWithReuseIdentifier: AssistantChatCollectionCell.identifier)
        collection.contentInset = .init(top: 10, left: 0, bottom: 20, right: 0)
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
    
    //MARK: - Interstitial AD
    var interstitial: GADInterstitialAd?

    //MARK: - References
    weak var delegate: ChatViewDelegate?
    
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
    
    func updateFreeMessageCountLabel() {
        if RevenueCatManager.shared.isSubscribe {
            freeMessageCountStackView.removeFromSuperview()
        } else {
            let freeMessageCount = MessageManager.shared.freeMessageCount
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                freeMessageCountLabel.text = "You have".localized() + " \(freeMessageCount) " +  "free message left.".localized()
            }
        }
    }
    
}

//MARK: - Button Actions
extension ChatView {
    @objc private func sendButtonTapped() {
        delegate?.chatView(self, sendButtonTapped: sendButton)
    }
    
    @objc private func getPremiumButtonTapped() {
        delegate?.chatView(self, getPremiumButtonTapped: getPremiumTextButton)
    }
}

//MARK: - Send Button Visibility
extension ChatView {
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

//MARK: - AdMob Ads Configure
extension ChatView {
    func loadInterstitialAd(completion: ((Bool) -> Void)? = nil) {
        if !RevenueCatManager.shared.isSubscribe {
            let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: AdMobConstants.testInterstitialAdUnitID, request: request) { [weak self] ad, error in
                guard let self else { return }
                
                if let error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    completion?(false)
                } else {
                    self.interstitial = ad
                    completion?(true)
                }
            }
        }
    }
}

//MARK: - Setup UI
extension ChatView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(chatCollectionView)
        addSubview(sendButton)
        addSubview(messageTextView)
        addSubview(freeMessageCountStackView)
        freeMessageCountStackView.addArrangedSubview(freeMessageCountLabel)
        freeMessageCountStackView.addArrangedSubview(getPremiumTextButton)
        
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
        
        chatCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(messageTextView.snp.top).offset(-25)
        }
        
        freeMessageCountStackView.snp.makeConstraints { make in
            make.bottom.equalTo(messageTextView.snp.top).offset(-5)
            make.leading.equalTo(messageTextView.snp.leading).offset(6)
            make.trailing.lessThanOrEqualTo(sendButton.snp.trailing).offset(-6)
            make.height.equalTo(20)
        }
        
    }
}
