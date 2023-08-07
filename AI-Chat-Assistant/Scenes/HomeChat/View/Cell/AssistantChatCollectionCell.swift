//
//  AssistantChatCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit

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
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var assistantTextLabel: UILabel = {
        let label = UILabel()
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
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 18
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func configure(with assistantMessage: String) {
        assistantTextLabel.text = assistantMessage
    }

}

//MARK: - Setup UI
extension AssistantChatCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(assistantImageView)
        addSubview(textStackView)
        textStackView.addArrangedSubview(assistantTextLabel)
        
        assistantImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.height.width.equalTo(36)
        }
        
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(assistantImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
