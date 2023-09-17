//
//  ChatModelSelectButton.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class ChatModelSelectButton: UIButton {
    
    //MARK: - Creating UI Elements
    private lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "ChatGPT")
        imageView.tintColor = .main
        return imageView
    }()
    
    private lazy var appAndModelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "arrowtriangle.down.fill")
        return imageView
    }()
    
    //MARK: - Init Methods
    init(model: GPTModel) {
        super.init(frame: .zero)
        setupViews()
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: GPTModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            appAndModelLabel.text = "\(AppName.name) (\(model.modelUIName))"
        }
    }
    
}

//MARK: - AddSubview / Constraints
extension ChatModelSelectButton {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(appLogoImageView)
        addSubview(appAndModelLabel)
        addSubview(rightImageView)
        
        appLogoImageView.snp.makeConstraints { make in
            make.leading.centerY.equalTo(self.safeAreaLayoutGuide)
            make.height.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.8)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.trailing.centerY.equalTo(self.safeAreaLayoutGuide)
            make.height.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
        }
        
        appAndModelLabel.snp.makeConstraints { make in
            make.leading.equalTo(appLogoImageView.snp.trailing).offset(5)
            make.trailing.equalTo(rightImageView.snp.leading).offset(-10)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
    }
}

