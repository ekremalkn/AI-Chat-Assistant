//
//  ChatHistorySenderView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import UIKit

final class ChatHistorySenderView: UIView {

    //MARK: - Creating UI Elements
    private lazy var senderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var senderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var senderMessageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
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
    
    func configure(senderRole: String) {
        
    }
    
}

//MARK: - AddSubview / Constraints
extension ChatHistorySenderView {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(senderStackView)
        senderStackView.addArrangedSubview(senderImageView)
        senderStackView.addArrangedSubview(senderMessageLabel)
        
        senderStackView.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.leading)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height)
        }
        
        senderImageView.snp.makeConstraints { make in
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.75)
        }
    }
}

