//
//  SettingsCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import UIKit

final class SettingsCollectionCell: UICollectionViewCell {
    static let identifier = "SettingsCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white.withAlphaComponent(0.8)
        return imageView
    }()
    
    private lazy var settingTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white.withAlphaComponent(0.8)
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "chat_right_arrow")
        return imageView
    }()
    
    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.3)
        return view
    }()
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with sectionItem: SettingsSectionItem) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            leftImageView.image = .init(named: sectionItem.itemImage)
            settingTitleLabel.text = sectionItem.itemTitle
        }
    }
}

//MARK: - AddSubview / Constraints
extension SettingsCollectionCell {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(seperatorView)
        addSubview(leftImageView)
        addSubview(rightImageView)
        addSubview(settingTitleLabel)
        
        
        seperatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.bottom.equalTo(seperatorView.snp.bottom).offset(-15)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.width.equalTo(leftImageView.snp.height)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalTo(leftImageView.snp.centerY)
            make.height.width.equalTo(leftImageView.snp.height)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        settingTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(20)
            make.trailing.equalTo(rightImageView.snp.leading).offset(-10)
            make.centerY.equalTo(leftImageView.snp.centerY)
            make.height.lessThanOrEqualTo(leftImageView.snp.height)
        }
        
    }
}

