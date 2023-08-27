//
//  ModelSelectCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class ModelSelectCollectionCell: UICollectionViewCell {
    static let identifier = "ModelSelectCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var modelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 7
        return stackView
    }()
    
    private lazy var modelTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var modelInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var modelMoreInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 10, weight: .regular)
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
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        modelImageView.layer.cornerRadius = modelImageView.frame.height / 2
        modelImageView.layer.masksToBounds = true
    }

    func configure(with model: GPTModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            modelImageView.image = .init(named: model.modelUIImage)
            modelTitleLabel.text = model.modelUIName
            modelInfoLabel.text = model.modelUIInfo
            modelMoreInfoLabel.text = model.modelUIMoreInfo
            switch model {
            case .gpt3_5Turbo:
                modelImageView.backgroundColor = .chatGPT3_5Background
            case .gpt4:
                modelImageView.backgroundColor = .chatGPT4Background
            }
        }
    }
    

}

//MARK: - Animations
extension ModelSelectCollectionCell {
    func cellSelected() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func cellDeSelected() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        }
    }
}


//MARK: - AddSubview / Constraints
extension ModelSelectCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(modelImageView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(modelTitleLabel)
        labelStackView.addArrangedSubview(modelInfoLabel)
        labelStackView.addArrangedSubview(modelMoreInfoLabel)
        
        modelImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(modelImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.centerY.equalTo(modelImageView.snp.centerY)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-10)
        }
        
    }
}
