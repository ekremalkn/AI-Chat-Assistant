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
    private lazy var freeMessageCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subscibeAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "SubscribeCellAnimation")
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
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        
        let fullText = "We've sent you a special gift. \nTap to receive".localized()

        // "Premium gift" metnini özelleştirmek için bir NSAttributedString oluşturun
        let attributedText = NSMutableAttributedString(string: fullText)
        let specialGiftRange = (fullText as NSString).range(of: "special gift".localized())
        let tapToReceiveRange = (fullText as NSString).range(of: "Tap to receive".localized())
        
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: tapToReceiveRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.lightGray, range: tapToReceiveRange)
        
        // Premium gift metninin fontunu ve rengini ayarlayın
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: specialGiftRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.init(hex: "FBBE3B"), range: specialGiftRange)

        // UILabel'e bu özelleştirilmiş metni ayarlayın
        label.attributedText = attributedText
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .init(hex: "FBBE3B")
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
    
    func updateFreeMessageCountLabel() {
        let freeMessageCount = MessageManager.shared.freeMessageCount
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            freeMessageCountLabel.text = "You have".localized() + " \(freeMessageCount) " + "free message left.".localized()
        }
    }
}

//MARK: - AddSubview / Constraints
extension SubscribeCollectionViewCell {
    private func setupViews() {
        backgroundColor = .vcBackground
        
        addSubview(subscibeAnimationView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(subscribeTitleLabel)
        addSubview(rightImageView)
        addSubview(freeMessageCountLabel)

        subscibeAnimationView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.75)
            make.width.equalTo(subscibeAnimationView.snp.height)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalTo(subscibeAnimationView.snp.centerY)
            make.height.width.equalTo(subscibeAnimationView.snp.height).multipliedBy(0.5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(subscibeAnimationView.snp.trailing).offset(10)
            make.centerY.equalTo(subscibeAnimationView.snp.centerY)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-10)
            make.trailing.lessThanOrEqualTo(rightImageView.snp.leading).offset(-10)
        }
        
        freeMessageCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subscibeAnimationView.snp.top)
            make.leading.equalTo(subscibeAnimationView.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.top.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.top)
        }
        
    }
}

