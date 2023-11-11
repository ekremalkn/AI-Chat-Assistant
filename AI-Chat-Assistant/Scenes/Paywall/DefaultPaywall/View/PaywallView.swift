//
//  PaywallView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import UIKit
import Lottie
import GhostTypewriter
import RevenueCat

protocol PaywallViewDelegate: AnyObject {
    func paywallView(_ view: PaywallView, restoreButtonTapped button: UIButton)
    func paywallView(_ view: PaywallView, closeButtonTapped button: UIButton)
    func paywallView(_ view: PaywallView, purchaseButtonTapped button: UIButton)
    func paywallView(_ view: PaywallView, changePlanButtonTapped button: UIButton)
    func paywallView(_ view: PaywallView, termOfServiceButtonTapped button: UIButton)
    func paywallView(_ view: PaywallView, privacyPolicyButtonTapped button: UIButton)
}

final class PaywallView: UIView {

    //MARK: - Creating UI Elements
    private lazy var paywallAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "PaywallChatbotAnimation")
        animationView.loopMode = .loop
        animationView.play()
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
        label.text = "Chatvantage PRO"
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.text = "Unlock Full Potential of AI Chatvantage".localized()
        return label
    }()

    private lazy var proFeaturesLabel: TypewriterLabel = {
        let label = TypewriterLabel()
        label.text = "🚀  " + "Powered by ChatGPT-3.5 & GPT-4".localized() + "\n\n💬 " + "Unlimited Questions & Answer".localized()  + "\n\n👩‍💼🧑‍💼 " + "Gain Access to Potent Assistants".localized() + "\n\n🆓 " + "Ads Free Experience".localized()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .white
        label.typingTimeInterval = 0.03
        return label
    }()
    
    private lazy var purchaseButtonAnimationView: LottieAnimationView = {
        let animatonView = LottieAnimationView(name: "PaywallPurchaseButtonAnimation")
        animatonView.loopMode = .loop
        animatonView.play()
        return animatonView
    }()
    
    private lazy var purchaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Chatvantage Pro".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .main
        button.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var planInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.text = "Cancel anytime.".localized()
        return label
    }()
    
    private lazy var changePlanButton: PaywallChangePlanButton = {
        let button = PaywallChangePlanButton(type: .system)
        button.setTitle("Change Plan".localized(), for: .normal)
        button.setTitleColor(.main, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(changePlanButtonTapped), for: .touchUpInside)
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
    weak var delegate: PaywallViewDelegate?

    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
    
    //MARK: - Configure With Package
    func configurePlanInfoLabelWithPackage(package: Package) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if package.packageType == .weekly {
                planInfoLabel.text = "Weekly Access".localized() + " \(package.localizedPriceString)" + "/week. ".localized() + "Cancel anytime.".localized()
                purchaseButton.setTitle("Get Chatvantage Pro".localized(), for: .normal)
            } else if package.packageType == .annual {
                planInfoLabel.text = "Yearly Access".localized() + " \(package.localizedPriceString)" + "/year. ".localized() + "Cancel anytime.".localized()
                purchaseButton.setTitle("Get Chatvantage Pro".localized(), for: .normal)
            }
        }
    }
    
    func startTypeWriteAnimation() {
        proFeaturesLabel.startTypewritingAnimation {
            
        }
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
extension PaywallView {
    @objc private func restoreButtonTapped() {
        delegate?.paywallView(self, restoreButtonTapped: restoreButton)
    }
    
    @objc private func closeButtonTapped() {
        delegate?.paywallView(self, closeButtonTapped: closeButton)
    }
    
    @objc private func purchaseButtonTapped() {
        delegate?.paywallView(self, purchaseButtonTapped: purchaseButton)
    }
    
    @objc private func changePlanButtonTapped() {
        delegate?.paywallView(self, changePlanButtonTapped: changePlanButton)
    }
    
    @objc private func termOfServiceButtonTapped() {
        delegate?.paywallView(self, termOfServiceButtonTapped: termOfServiceButton)
    }
    
    @objc private func privacyPolicyButtonTapped() {
        delegate?.paywallView(self, privacyPolicyButtonTapped: privacyPolicyButton)
    }
}


//MARK: - AddSubview / Constraints
extension PaywallView {
    private func setupViews() {
        backgroundColor = .vcBackground
        
        addSubview(paywallAnimationView)
        addSubview(titleLabelStackView)
        titleLabelStackView.addArrangedSubview(titleLabel)
        titleLabelStackView.addArrangedSubview(subTitleLabel)
        addSubview(topButtonStackView)
        topButtonStackView.addArrangedSubview(restoreButton)
        topButtonStackView.addArrangedSubview(closeButton)
        addSubview(proFeaturesLabel)
        addSubview(purchaseButtonAnimationView)
        addSubview(purchaseButton)
        addSubview(changePlanButton)
        addSubview(planInfoLabel)
        addSubview(documentsButtonStackView)
        documentsButtonStackView.addArrangedSubview(termOfServiceButton)
        documentsButtonStackView.addArrangedSubview(privacyPolicyButton)
        
        paywallAnimationView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.snp.centerY)
        }
        
        topButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(40)
        }
        
        titleLabelStackView.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualTo(paywallAnimationView.snp.bottom).offset(-60)
            make.centerX.equalTo(paywallAnimationView.snp.centerX)
            make.width.lessThanOrEqualTo(paywallAnimationView.snp.width).offset(-40)
        }
        
        documentsButtonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
            make.height.equalTo(20)
        }
        
        planInfoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(documentsButtonStackView.snp.top).offset(-10)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
        }
        
        changePlanButton.snp.makeConstraints { make in
            make.bottom.equalTo(planInfoLabel.snp.top).offset(-10)
            make.width.greaterThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.35)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(40)
        }
        
        purchaseButton.snp.makeConstraints { make in
            make.bottom.equalTo(changePlanButton.snp.top).offset(-10)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
            make.height.equalTo(60)
        }
        
        proFeaturesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabelStackView.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
            make.bottom.lessThanOrEqualTo(purchaseButton.snp.top).offset(-20)
        }
        
        purchaseButtonAnimationView.snp.makeConstraints { make in
            make.center.equalTo(purchaseButton)
            make.height.width.equalTo(200)
        }
        

    }
}

