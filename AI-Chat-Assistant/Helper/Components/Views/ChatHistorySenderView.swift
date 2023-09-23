//
//  ChatHistorySenderView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import UIKit

final class ChatHistorySenderView: UIView {

    //MARK: - Creating UI Elements
    private lazy var senderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var senderMessageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
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
    
    func configure(chatMessageItem: ChatMessageItem) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch chatMessageItem.role {
            case "assistant":
                senderImageView.image = .init(named: "appLogo")
                senderMessageLabel.text = chatMessageItem.content
                senderMessageLabel.textColor = .white.withAlphaComponent(0.7)
                senderImageView.tintColor = .main
            case "user":
                senderImageView.image = .init(systemName: "person.fill")
                senderMessageLabel.text = chatMessageItem.content
                senderMessageLabel.textColor = .white
                senderImageView.tintColor = .white
            default:
                break
            }
        }
        
        
    }
    
}

//MARK: - AddSubview / Constraints
extension ChatHistorySenderView {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(senderImageView)
        addSubview(senderMessageLabel)
        
        senderImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.85)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
        
        senderMessageLabel.snp.makeConstraints { make in
            make.leading.equalTo(senderImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing)
            make.centerY.equalTo(senderImageView.snp.centerY)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height)
        }
        
    }
}

