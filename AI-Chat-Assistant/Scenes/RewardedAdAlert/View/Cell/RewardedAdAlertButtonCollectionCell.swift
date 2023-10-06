//
//  RewardedAdAlertButtonCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.10.2023.
//

import UIKit

final class RewardedAdAlertButtonCollectionCell: UICollectionViewCell {
    static let identifier = "RewardedAdAlertButtonCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 3
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
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    func configure(with data: RewardedAdAlertButtonType) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            buttonImageView.image = .init(named: data.buttonImage)
            buttonTitleLabel.text = data.buttonTitle
        }
    }
}

//MARK: - AddSubview / Constraints
extension RewardedAdAlertButtonCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(buttonImageView)
        addSubview(buttonTitleLabel)
        
        buttonImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.6)
        }
        
        buttonTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(buttonImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.centerY.equalTo(buttonImageView.snp.centerY)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-10)
        }
    }
}


