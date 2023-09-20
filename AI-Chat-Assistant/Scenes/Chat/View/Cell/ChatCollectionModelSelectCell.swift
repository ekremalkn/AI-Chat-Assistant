//
//  ChatCollectionModelSelectCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 20.09.2023.
//

import UIKit

final class ChatCollectionModelSelectCell: UICollectionViewCell {
    static let identifier = "ChatCollectionModelSelectCell"
    
    //MARK: - Creating UI Elements
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.6)
        label.text = "Model"
        return label
    }()
    
    private lazy var modelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: "chevron.down")
        imageView.tintColor = .white.withAlphaComponent(0.6)
        return imageView
    }()
    
    //MARK: - Inıt methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    func configure(with gptModel: GPTModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            modelLabel.text = "Default: ChatGPT (\(gptModel.modelUIName))"
        }
    }
    
}

//MARK: - AddSubview / Constraints
extension ChatCollectionModelSelectCell {
    private func setupViews() {
        backgroundColor = .clear
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.main.withAlphaComponent(0.5).cgColor
        
        addSubview(rightImageView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(modelLabel)
        
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(rightImageView.snp.leading).offset(-20)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-10)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
    }
}
