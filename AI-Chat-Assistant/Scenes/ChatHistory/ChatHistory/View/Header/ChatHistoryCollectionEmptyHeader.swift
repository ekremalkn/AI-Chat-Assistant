//
//  ChatHistoryCollectionEmptyHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import UIKit
import Lottie

final class ChatHistoryCollectionEmptyHeader: UICollectionReusableView {
    static let identifier = "ChatHistoryCollectionEmptyHeader"
    
    //MARK: - Crating UI Elements
    private lazy var emptyChatHistoryAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "EmptyChatHistoryAnimation")
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No History Item"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "You can press the button below to start a chat."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white.withAlphaComponent(0.5)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var startChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .main
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Start Chat", for: .normal)
        return button
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startChatButton.layer.cornerRadius = 12
        startChatButton.layer.masksToBounds = true
    }
    
}

//MARK: - AddSubview / Constraints
extension ChatHistoryCollectionEmptyHeader {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(startChatButton)
        addSubview(emptyChatHistoryAnimationView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subTitleLabel)
        
        startChatButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        emptyChatHistoryAnimationView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(emptyChatHistoryAnimationView.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualTo(startChatButton.snp.top).offset(-20)
            make.leading.trailing.equalTo(emptyChatHistoryAnimationView)
        }
    }
}
