//
//  ModelSelectView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

protocol ModelSelectViewDelegate: AnyObject {
    func modelSelectView(_ view: ModelSelectView, closeButtonTapped button: UIButton)
}

final class ModelSelectView: UIView {
    
    //MARK: - Creating UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.text = "Choose Model".localized()
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(.init(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var modelSelectCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ModelSelectCollectionCell.self, forCellWithReuseIdentifier: ModelSelectCollectionCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }()
    
    //MARK: - References
    weak var delegate: ModelSelectViewDelegate?
    
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
        self.layer.cornerRadius = 24
        self.layer.masksToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    
}

//MARK: - Button Actions
extension ModelSelectView {
    @objc private func closeButtonTapped() {
        delegate?.modelSelectView(self, closeButtonTapped: closeButton)
    }
}

//MARK: - AddSubview / Constraints
extension ModelSelectView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(modelSelectCollectionView)
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.width.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(closeButton.snp.leading).offset(-20)
        }
        
        modelSelectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
    }
}
