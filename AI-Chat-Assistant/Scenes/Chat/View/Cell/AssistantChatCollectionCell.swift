//
//  AssistantChatCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit
import Lottie
import GhostTypewriter

protocol AssistantChatCollectionCellDelegate: AnyObject {
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, reGenerateButtonTapped: Void)
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, copyButtonTapped copiedText: String)
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, shareButtonTapped textToShare: String)
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, feedBackButtonTapped: Void)
}

final class AssistantChatCollectionCell: UICollectionViewCell {
    static let identifier = "AssistantChatCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var assistantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: "circle.fill")
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
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(named: "chat_more"), for: .normal)
        button.tintColor = .white
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    //MARK: - References
    weak var delegate: AssistantChatCollectionCellDelegate?
    
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
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if assistantMessage.isEmpty {
                typingAnimation.play()
                assistantTextLabel.isHidden = true
                typingAnimation.isHidden = false
                moreButton.isEnabled = false
            } else {
                moreButton.isEnabled = true
                typingAnimation.isHidden = true
                assistantTextLabel.isHidden = false
                typingAnimation.stop()
                assistantTextLabel.text = assistantMessage
            }
        }
        
    }
    
}

//MARK: - Configure More Button
extension AssistantChatCollectionCell {
    func setMoreButtonToMenu(_ showReGenerateButton: Bool) {
        let share = UIAction(title: "Share", image: .init(systemName: "square.and.arrow.up.fill")) { [weak self] _ in
            guard let self, let text = assistantTextLabel.text else { return }
            delegate?.assistantChatCollectionCell(self, shareButtonTapped: text)
        }
        
        let copy = UIAction(title: "Copy", image: .init(systemName: "doc.on.doc.fill")) { [weak self] _ in
            guard let self, let text = assistantTextLabel.text else { return }
            delegate?.assistantChatCollectionCell(self, copyButtonTapped: text)
        }
        
        let feedback = UIAction(title: "Feedback", image: .init(systemName: "hand.thumbsup.fill")) { [weak self] _ in
            guard let self else { return }
            delegate?.assistantChatCollectionCell(self, feedBackButtonTapped: ())
            
        }
        var elements: [UIAction] = [copy, share, feedback]
        
        if showReGenerateButton {
            let reGenerate = UIAction(title: "Re-Generate", image: .init(systemName: "arrow.triangle.2.circlepath")) { [weak self] _ in
                guard let self else { return }
                delegate?.assistantChatCollectionCell(self, reGenerateButtonTapped: ())
            }
            
            elements.insert(reGenerate, at: 0)
        }
        
        let moreMenu = UIMenu(title: "More About Text", children: elements)
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            moreButton.menu = moreMenu
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
        addSubview(moreButton)
        
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
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.width.equalTo(36)
        }
        
        assistantTextLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(assistantImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.moreButton.snp.leading).offset(-5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
