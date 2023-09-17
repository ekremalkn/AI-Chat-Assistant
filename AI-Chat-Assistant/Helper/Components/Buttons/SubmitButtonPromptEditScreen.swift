//
//  SubmitButtonPromptEditScreen.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit

final class SubmitButtonPromptEditScreen: UIButton {

    //MARK: - Creating UI Elements
    private lazy var buttonContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 3
        return stackView
    }()
    
    private lazy var buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Submit"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "chat_send")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//MARK: - AddSubview / Constraints
extension SubmitButtonPromptEditScreen {
    private func setupViews() {
        backgroundColor = .main
        addSubview(buttonTitleLabel)
        addSubview(buttonImageView)
   
        buttonImageView.snp.makeConstraints { make in
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.75)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
        
        buttonTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-(20 + buttonImageView.frame.width + 10))
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
        }
    }
}

