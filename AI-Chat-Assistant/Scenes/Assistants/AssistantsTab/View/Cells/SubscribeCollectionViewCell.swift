//
//  SubscribeCollectionViewCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 25.09.2023.
//

import UIKit
import Lottie

final class SubscribeCollectionViewCell: UICollectionViewCell {
    static let identifier = "SubscribeCollectionViewCell"
    
    //MARK: - Creating UI Elements
    private lazy var subscibeAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "")
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var subscribeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.text = "Chatvantage (GPT-4) has sent you a"
        return label
    }()
    
    private lazy var subscribeSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.text = "Premimum gift. Tap to receive"
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .main
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "chat_right_arrow")
        return imageView
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - AddSubview / Constraints
extension SubscribeCollectionViewCell {
    private func setupViews() {
        backgroundColor = .vcBackground
        
        addSubview(subscibeAnimationView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(subscribeTitleLabel)
        labelStackView.addArrangedSubview(subscribeSubTitleLabel)
        addSubview(rightImageView)
        
        subscibeAnimationView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.85)
            make.width.equalTo(subscibeAnimationView.snp.height)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalTo(subscibeAnimationView.snp.centerY)
            make.height.width.equalTo(subscibeAnimationView.snp.height)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(subscibeAnimationView.snp.trailing).offset(10)
            make.centerY.equalTo(subscibeAnimationView.snp.centerY)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-10)
            make.trailing.lessThanOrEqualTo(rightImageView.snp.leading).offset(-10)
        }
    }
}

