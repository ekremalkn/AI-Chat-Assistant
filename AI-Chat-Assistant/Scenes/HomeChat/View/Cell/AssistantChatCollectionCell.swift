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
        label.text = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through "
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

}

//MARK: - Setup UI
extension AssistantChatCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(assistantImageView)
        addSubview(textStackView)
        textStackView.addArrangedSubview(assistantTextLabel)
        
        assistantImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.width.equalTo(36)
        }
        
        textStackView.snp.makeConstraints { make in
            make.centerY.equalTo(assistantImageView.snp.centerY)
            make.top.equalTo(assistantImageView.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.equalTo(assistantImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
    }
}
