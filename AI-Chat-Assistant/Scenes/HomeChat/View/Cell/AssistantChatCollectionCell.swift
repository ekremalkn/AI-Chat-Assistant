//
//  AssistantChatCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit
import Lottie
import GhostTypewriter

final class AssistantChatCollectionCell: UICollectionViewCell {
    static let identifier = "AssistantChatCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var assistantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: "house.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var typingAnimation: LottieAnimationView = {
        let animation = LottieAnimationView(name: "AssistantTypingAnimation")
        animation.loopMode = .loop
        return animation
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var assistantTextLabel: TypewriterLabel = {
        let label = TypewriterLabel()
        label.textAlignment = .left
        label.numberOfLines  = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
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
    

    //MARK: - Configure
    func configure(with assistantMessage: String) {
        if assistantMessage.isEmpty {
            typingAnimation.play()
        } else {
            typingAnimation.isHidden = true
            typingAnimation.stop()
            assistantTextLabel.text = assistantMessage
        }
    }

}

//MARK: - Setup UI
extension AssistantChatCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(assistantImageView)
        addSubview(typingAnimation)
        addSubview(assistantTextLabel)
        
        assistantImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.width.height.equalTo(36)
        }
        
        typingAnimation.snp.makeConstraints { make in
            make.leading.equalTo(assistantImageView.snp.trailing).offset(10)
            make.centerY.equalTo(assistantImageView.snp.centerY)
            make.height.equalTo(assistantImageView.snp.height).multipliedBy(0.8)
        }
        
        assistantTextLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(assistantImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
