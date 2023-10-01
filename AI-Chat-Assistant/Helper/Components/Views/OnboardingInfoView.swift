//
//  OnboardingInfoView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 1.10.2023.
//

import UIKit

final class OnboardingInfoView: UIView {

    //MARK: - Creating UI Elements
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Init Methods
    init(backgroundColor: UIColor, infoText: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        infoLabel.text = infoText
        setupViews()
        alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }

}

extension OnboardingInfoView {
    private func setupViews() {
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(infoLabel)
        
        infoStackView.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).offset(-20)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).offset(-20)
        }
    }
}
