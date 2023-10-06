//
//  RewardedAdAlertView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.10.2023.
//

import UIKit

protocol RewardedAdAlertViewDelegate: AnyObject {
    func rewardedAdAlertView(_ view: RewardedAdAlertView, closeButtonTapped button: UIButton)
}

final class RewardedAdAlertView: UIView {

    //MARK: - Creating UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 3
        label.text = "Watch an ad to continue or get Chatvantage Pro".localized()
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(.init(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var rewardedAdAlertButtonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(RewardedAdAlertButtonCollectionCell.self, forCellWithReuseIdentifier: RewardedAdAlertButtonCollectionCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }()
    
    //MARK: - References
    weak var delegate: RewardedAdAlertViewDelegate?

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
        self.layer.cornerRadius = 18
        self.layer.masksToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

}

//MARK: - Button Actions
extension RewardedAdAlertView {
    @objc private func closeButtonTapped() {
        delegate?.rewardedAdAlertView(self, closeButtonTapped: closeButton)
    }
}

//MARK: - AddSubview / Constraints
extension RewardedAdAlertView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(rewardedAdAlertButtonCollectionView)
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.width.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(closeButton.snp.leading).offset(-10)
        }
        
        rewardedAdAlertButtonCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
    }
}


