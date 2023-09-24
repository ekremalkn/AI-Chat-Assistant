//
//  PaywallView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import UIKit
import Lottie
import GhostTypewriter

final class PaywallView: UIView {

    //MARK: - Creating UI Elements
    private lazy var paywallAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "PaywallChatbotAnimation")
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    private lazy var titleLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        label.numberOfLines = 0
        label.textColor = .main
        label.text = "Get PRO Access"
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        label.text = "Unleash the full Potential"
        return label
    }()
    
    private lazy var proFeaturesView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var proFeaturesLabel: TypewriterLabel = {
        let label = TypewriterLabel()
        label.text = "Powered by GPT-4, Unlimites Questions & Answers, Gain Access to Potent Assistants, Ads Free Experience"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .white
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
        button.setTitle("Subscribe To Unlock", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .main
        return button
    }()
    
    private lazy var changePlanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Plan", for: .normal)
        button.setTitleColor(.main, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var planInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.text = "Start your 3 days trial. Then $5.99/week. Cancel anytime."
        return label
    }()
    
    private lazy var documentsButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var termOfServiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Term of Service", for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
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
    
    func startTypeWriteAnimation() {
        proFeaturesLabel.startTypewritingAnimation {
            
        }
    }
}

//MARK: - AddSubview / Constraints
extension PaywallView {
    private func setupViews() {
        backgroundColor = .black
        
        addSubview(titleLabelStackView)
        titleLabelStackView.addArrangedSubview(titleLabel)
        titleLabelStackView.addArrangedSubview(subTitleLabel)
        addSubview(paywallAnimationView)
//        addSubview(proFeaturesView)
        addSubview(proFeaturesLabel)
        addSubview(purchaseButtonAnimationView)
        addSubview(purchaseButton)
        addSubview(changePlanButton)
        addSubview(planInfoLabel)
        addSubview(documentsButtonStackView)
        documentsButtonStackView.addArrangedSubview(termOfServiceButton)
        documentsButtonStackView.addArrangedSubview(privacyPolicyButton)
        
        
        documentsButtonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(40)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
        }
        
        planInfoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(documentsButtonStackView.snp.top).offset(-20)
            make.leading.trailing.equalTo(changePlanButton)
        }
        
        changePlanButton.snp.makeConstraints { make in
            make.bottom.equalTo(planInfoLabel.snp.top).offset(10)
            make.centerX.equalTo(purchaseButton.snp.centerX)
            make.width.equalTo(purchaseButton.snp.width).multipliedBy(0.75)
            make.height.equalTo(50)
        }
        
        purchaseButton.snp.makeConstraints { make in
            make.bottom.equalTo(changePlanButton.snp.top).offset(-20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-60)
            make.height.equalTo(60)
        }
        
        purchaseButtonAnimationView.snp.makeConstraints { make in
            make.center.equalTo(purchaseButton.snp.center)
            make.height.width.equalTo(200)
        }
        
        paywallAnimationView.snp.makeConstraints { make in
            make.top.equalTo(titleLabelStackView.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(purchaseButton.snp.top)
        }
        
        proFeaturesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabelStackView.snp.bottom).offset(40)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing)
            make.bottom.lessThanOrEqualTo(purchaseButton.snp.top).offset(-20)
        }
        
        titleLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.lessThanOrEqualTo(paywallAnimationView.snp.top).offset(-20)
            make.width.lessThanOrEqualTo(paywallAnimationView.snp.width).offset(-40)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
        }


    }
}

