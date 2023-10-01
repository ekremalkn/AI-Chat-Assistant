//
//  SplashView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 1.10.2023.
//

import UIKit
import MorphingLabel

final class SplashView: UIView {

    //MARK: - Creating UI Elements
    private lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "appLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .main
        return imageView
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 34, weight: .black)
        label.alpha = 0
        label.text = AppInfo.name
        return label
    }()
    
    private lazy var appInfoLabel: LTMorphingLabel = {
        let label = LTMorphingLabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.morphingEnabled = true
        return label
    }()
    
    //MARK: - Variables
    private var appInfoTextArray = [
        "Powered by GPT-3.5 & GPT-4".localized(),
        "Fastest responses".localized(),
        "Best assistants and suggestions".localized()
        ]
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func animateAppLogo(duration: TimeInterval, completion: @escaping (() -> Void)) {

        DispatchQueue.main.async { [weak self ] in
            guard let self else { return }
            updateLabelWithStrings(strings: appInfoTextArray) {
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                let rotationAngle: CGFloat = CGFloat.pi * 2.0
                let rotationDuration: TimeInterval = duration
                rotationAnimation.toValue = rotationAngle
                rotationAnimation.duration = rotationDuration
                self.appLogoImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
                
                
                UIView.animate(withDuration: duration, animations: {
                    self.appLogoImageView.transform = .init(translationX: 0, y: -60)
                    self.appNameLabel.alpha = 1

                }) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        completion()
                    }
                }
            }
            
        }

    }
    
    func updateLabelWithStrings(strings: [String], completion: @escaping () -> Void) {
        var currentIndex = 0
        
        // Timer oluşturup her 1 saniyede bir çalıştırmak için
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }
            // Label metnini güncelle
            DispatchQueue.main.async {
                self.appInfoLabel.text = strings[currentIndex]
                
                currentIndex += 1
                
                // Mevcut dizinin dışına çıkma kontrolü
                if currentIndex >= strings.count {
                    timer.invalidate()
                    completion()
                }

            }
        }
        
        // Timer'ı başlat
        timer.fire()
        
        // Timer'ı durdurmak istediğinizde kullanabilirsiniz
        // timer.invalidate()
    }

}

//MARK: - AddSubview / Constraints
extension SplashView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(appLogoImageView)
        addSubview(appNameLabel)
        addSubview(appInfoLabel)
        
        appLogoImageView.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(appLogoImageView.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        appInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(40)
            make.centerX.equalTo(appNameLabel.snp.centerX)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
    }
}

