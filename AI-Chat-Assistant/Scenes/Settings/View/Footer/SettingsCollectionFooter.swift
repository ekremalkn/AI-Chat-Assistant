//
//  SettingsCollectionFooter.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import UIKit

final class SettingsCollectionFooter: UICollectionReusableView {
    static let identifier = "SettingsCollectionFooter"
    
    //MARK: - Creating UI Elements
    private lazy var appInfoHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "appLogo_36px")
        imageView.tintColor = .main
        return imageView
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = AppInfo.name
        label.textAlignment = .left
        label.textColor  = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var appInfoVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.4)
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            label.text = "v\(appVersion)"
        }
        return label
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
extension SettingsCollectionFooter {
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(appInfoHStackView)
        appInfoHStackView.addArrangedSubview(appLogoImageView)
        appInfoHStackView.addArrangedSubview(appNameLabel)
        addSubview(appInfoVStackView)
        appInfoVStackView.addArrangedSubview(appInfoHStackView)
        appInfoVStackView.addArrangedSubview(appVersionLabel)
        
        appInfoVStackView.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
        }
    }
}

