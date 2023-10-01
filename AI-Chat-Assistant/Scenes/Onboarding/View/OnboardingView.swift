//
//  OnboardingView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 30.09.2023.
//

import UIKit
import GhostTypewriter

protocol OnboardingViewDelegate: AnyObject {
    func onboardingView(_ view: OnboardingView, continueButtonTapped button: UIButton)
}

final class OnboardingView: UIView {

    //MARK: - Creating UI Elements
    private lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .main
        imageView.alpha = 0.3
        imageView.image = .init(named: "appLogo")
        return imageView
    }()
    
    private lazy var titleLabel: TypewriterLabel = {
        let label = TypewriterLabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.text = "AI Has Never Been This Useful".localized()
        label.typingTimeInterval = 0.025
        return label
    }()
    
    private lazy var subTitleLabel: TypewriterLabel = {
        let label = TypewriterLabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .lightGray.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Welcome to the Advantageous Era of AI-Powered Conversations with Chatvantage".localized()
        label.isHidden = true
        label.typingTimeInterval = 0.025
        return label
    }()
    
    private lazy var infoView1 = OnboardingInfoView(backgroundColor: .cellBackground.withAlphaComponent(0.3), infoText: "You can ask anything".localized())
    private lazy var infoView2 = OnboardingInfoView(backgroundColor: .main.withAlphaComponent(0.3), infoText: "Powered by GPT3.5 & GPT4".localized())
    private lazy var infoView3 = OnboardingInfoView(backgroundColor: .cellBackground.withAlphaComponent(0.3), infoText: "Supports all languages".localized())
    private lazy var infoView4 = OnboardingInfoView(backgroundColor: .main.withAlphaComponent(0.3), infoText: "Multiple assistants & suggestions".localized())
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .main
        button.setTitle("Continue".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    //MARK: - References
    weak var delegate: OnboardingViewDelegate?

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
        continueButton.layer.cornerRadius = 12
        continueButton.layer.masksToBounds = true
        
    }
    
    
    
}

//MARK: - Button Actions
extension OnboardingView {
    @objc private func continueButtonTapped() {
        delegate?.onboardingView(self, continueButtonTapped: continueButton)
    }
}


//MARK: - Animations
extension OnboardingView {
    
    func startLabelAnimations(completion: @escaping () -> Void) {
        DispatchQueue.main.async {[weak self] in
            guard let self else { return }
            self.titleLabel.startTypewritingAnimation {
                self.subTitleLabel.isHidden = false
                self.subTitleLabel.startTypewritingAnimation {
                    self.showViews(completion: completion)
                }
            }
        }
    }
    
    func showViews(completion: @escaping () -> Void) {
        // animate views
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            UIView.animate(withDuration: 0.33) {
                self.infoView1.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.33) {
                    self.infoView2.alpha = 1
                } completion: { _ in
                    UIView.animate(withDuration: 0.33) {
                        self.infoView3.alpha = 1
                    } completion: { _ in
                        UIView.animate(withDuration: 0.33) {
                            self.infoView4.alpha =  1
                        } completion: { _ in
                            self.showContinueButton(completion: completion)
                        }
                    }
                }
            }
        }

   }
    
    
    func showContinueButton(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            UIView.animate(withDuration: 0.33) {
                self.continueButton.alpha = 1
            }
        }
    }
}


extension OnboardingView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(appLogoImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(infoView1)
        addSubview(infoView2)
        addSubview(infoView3)
        addSubview(infoView4)
    
        addSubview(continueButton)
        
        appLogoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        infoView1.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            make.leading.equalTo(appLogoImageView.snp.trailing).offset(-40)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.greaterThanOrEqualTo(60)
        }
        
        infoView2.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(infoView1.snp.bottom).offset(35)
            make.leading.equalTo(infoView1.snp.leading).offset(20)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.greaterThanOrEqualTo(60)
        }
        
        infoView3.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(infoView2.snp.bottom).offset(35)
            make.leading.equalTo(infoView2.snp.leading).offset(20)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.greaterThanOrEqualTo(60)
        }
        
        infoView4.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(infoView3.snp.bottom).offset(35)
            make.leading.equalTo(infoView1.snp.leading).offset(20)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.greaterThanOrEqualTo(60)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(60)
        }

    }
}


