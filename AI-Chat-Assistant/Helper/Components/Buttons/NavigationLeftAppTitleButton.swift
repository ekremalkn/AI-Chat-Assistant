//
//  NavigationLeftAppTitleButton.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import UIKit

final class NavigationLeftAppTitleButton: UIButton {
    
    //MARK: - Creating UI Elements
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: AppInfo.appLogoImage)
        imageView.tintColor = .main
        return imageView
    }()
    
    private lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.text = AppInfo.name
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
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
        leftImageView.layer.cornerRadius = leftImageView.frame.height / 2
        leftImageView.layer.masksToBounds = true
    }
}

//MARK: - AddSubview / Constraints
extension NavigationLeftAppTitleButton {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(leftImageView)
        addSubview(appTitleLabel)
        
        leftImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.6)
        }
        
        appTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height)
            
        }
    }
}

