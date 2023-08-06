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
        label.text = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through "
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

    
    func configure() {
        
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
            make.top.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.width.equalTo(36)
        }
        
        textStackView.snp.makeConstraints { make in
            make.centerY.equalTo(userImageView.snp.centerY)
            make.top.equalTo(userImageView.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
    }
}
