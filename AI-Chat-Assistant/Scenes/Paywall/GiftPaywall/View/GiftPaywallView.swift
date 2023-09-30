//
//  GiftPaywallView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 29.09.2023.
//

import UIKit
import Lottie
import GhostTypewriter
import RevenueCat

protocol GiftPaywallViewDelegate: AnyObject {
    func giftPaywallView(_ view: GiftPaywallView, restoreButtonTapped button: UIButton)
    func giftPaywallView(_ view: GiftPaywallView, closeButtonTapped button: UIButton)
    func giftPaywallView(_ view: GiftPaywallView, purchaseButtonTapped button: UIButton)
    func giftPaywallView(_ view: GiftPaywallView, termOfServiceButtonTapped button: UIButton)
    func giftPaywallView(_ view: GiftPaywallView, privacyPolicyButtonTapped button: UIButton)
}

final class GiftPaywallView: UIView {
    
    //MARK: - Creating UI Elements
    private lazy var paywallAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "PaywallChatbotAnimation")
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    private lazy var paywallGiftAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "GiftPaywallAnimation")
        animationView.loopMode = .loop
        animationView.play()
        animationView.animationSpeed = 2
        return animationView
    }()
    
    private lazy var topButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var restoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Restore".localized(), for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .lightGray.withAlphaComponent(0.1)
        button.setImage(.init(named: "chat_cross"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.alpha = 0
        button.isEnabled = false
        return button
    }()
    
    private lazy var titleLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34, weight: .black)
        label.numberOfLines = 0
        label.textColor = .main
        label.text = " Chatvantage PRO \n 🎁"
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        label.text = "Use this gift offer and have GPT-4, Unlimited Questions & Answer, Gain Access to Potent Assistants, Ads Free Experience".localized()
        return label
    }()
    
    lazy var packageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collection.register(GiftPackageCollectionCell.self, forCellWithReuseIdentifier: GiftPackageCollectionCell.identifier)
        return collection
    }()
    
    private lazy var planInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.text = "Cancel anytime".localized()
        return label
    }()
    
    private lazy var purchaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with gift plan".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .main
        button.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var documentsButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var termOfServiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Term of Service".localized(), for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(termOfServiceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy Policy".localized(), for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(privacyPolicyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - References
    weak var delegate: GiftPaywallViewDelegate?
    
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
        purchaseButton.layer.cornerRadius = 12
        purchaseButton.layer.masksToBounds = true
    }
    
    //MARK: - Button Animation
    func showCloseButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self else { return }
                closeButton.alpha = 1
            } completion: { [weak self] _ in
                guard let self else { return }
                closeButton.isEnabled = true
            }
        }
    }
}


//MARK: - Button Actions
extension GiftPaywallView {
    @objc private func restoreButtonTapped() {
        delegate?.giftPaywallView(self, restoreButtonTapped: restoreButton)
    }
    
    @objc private func closeButtonTapped() {
        delegate?.giftPaywallView(self, closeButtonTapped: closeButton)
    }
    
    @objc private func purchaseButtonTapped() {
        delegate?.giftPaywallView(self, purchaseButtonTapped: purchaseButton)
    }
    
    @objc private func termOfServiceButtonTapped() {
        delegate?.giftPaywallView(self, termOfServiceButtonTapped: termOfServiceButton)
    }
    
    @objc private func privacyPolicyButtonTapped() {
        delegate?.giftPaywallView(self, privacyPolicyButtonTapped: privacyPolicyButton)
    }
}

//MARK: - AddSubview / Constraints
extension GiftPaywallView {
    private func setupViews() {
        backgroundColor = .vcBackground
        
        addSubview(paywallAnimationView)
        addSubview(paywallGiftAnimationView)
        addSubview(topButtonStackView)
        topButtonStackView.addArrangedSubview(restoreButton)
        topButtonStackView.addArrangedSubview(closeButton)
        addSubview(titleLabelStackView)
        titleLabelStackView.addArrangedSubview(titleLabel)
        titleLabelStackView.addArrangedSubview(subTitleLabel)
        //        addSubview(proFeaturesLabel)
        addSubview(packageCollectionView)
        addSubview(purchaseButton)
        addSubview(planInfoLabel)
        addSubview(documentsButtonStackView)
        documentsButtonStackView.addArrangedSubview(termOfServiceButton)
        documentsButtonStackView.addArrangedSubview(privacyPolicyButton)
        
        paywallAnimationView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.snp.centerY).offset(-80)
        }
        
        paywallGiftAnimationView.snp.makeConstraints { make in
            make.top.equalTo(paywallAnimationView.snp.top)
            make.centerX.equalTo(paywallAnimationView.snp.centerX)
            make.height.width.equalTo(paywallAnimationView.snp.height).multipliedBy(0.5)
        }
        
        topButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(40)
        }
        
        titleLabelStackView.snp.makeConstraints { make in
            make.bottom.equalTo(paywallAnimationView.snp.bottom).offset(-20)
            make.centerX.equalTo(paywallAnimationView.snp.centerX)
            make.width.lessThanOrEqualTo(paywallAnimationView.snp.width).offset(-30)
        }
        
        documentsButtonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
            make.height.equalTo(20)
        }
        
        purchaseButton.snp.makeConstraints { make in
            make.bottom.equalTo(documentsButtonStackView.snp.top).offset(-40)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
            make.height.equalTo(60)
        }
        
        packageCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(purchaseButton.snp.top).offset(-40)
            make.top.equalTo(paywallAnimationView.snp.bottom)
        }
        
        planInfoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(purchaseButton.snp.top).offset(-10)
            make.top.lessThanOrEqualTo(packageCollectionView.snp.bottom).offset(10)
            make.centerX.equalTo(purchaseButton.snp.centerX)
            make.width.equalTo(purchaseButton.snp.width)
        }
        
        
        
    }
}


