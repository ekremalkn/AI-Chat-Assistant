//
//  UserChatCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit
import SnapKit

final class UserChatCollectionCell: UICollectionViewCell {
    static let identifier = "UserChatCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "chat_user")
        return imageView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var userTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
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
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

    
    func configure(with userMessage: String) {
        userTextLabel.text = userMessage
    }

}

//MARK: - Setup UI 
extension UserChatCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(userImageView)
        addSubview(textStackView)
        textStackView.addArrangedSubview(userTextLabel)
        
        userImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.height.width.equalTo(36)
        }
        
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)

        }
    }
}
