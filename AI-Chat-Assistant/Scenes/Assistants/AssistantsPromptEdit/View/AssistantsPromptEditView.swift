//
//  AssistantsPromptEditView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit

protocol AssistantsPromptEditViewDelegate: AnyObject {
    func assistantsPromptEditView(_ view: AssistantsPromptEditView, submitButtonTapped button: UIButton)
    func assistantsPromptEditView(_ view: AssistantsPromptEditView, getPremiumButtonTapped button: UIButton)
}

final class AssistantsPromptEditView: UIView {

    //MARK: - Creating UI Elements
    lazy var assistantsPromptEditCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        collection.backgroundColor = .vcBackground
        collection.register(AssistantsPromptEditCollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AssistantsPromptEditCollectionSectionHeader.identifier)
        collection.register(AssistantsPromptEditCollectionCell.self, forCellWithReuseIdentifier: AssistantsPromptEditCollectionCell.identifier)
        return collection
    }()
    
    private lazy var submitButton: SubmitButtonPromptEditScreen = {
        let button = SubmitButtonPromptEditScreen(type: .system)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var freeMessageCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var freeMessageCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var getPremiumTextButton: GetPremiumTextButton = {
        let button = GetPremiumTextButton(type: .system)
        button.addTarget(self, action: #selector(getPremiumButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - References
    weak var delegate: AssistantsPromptEditViewDelegate?

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
        submitButton.layer.cornerRadius = 12
        submitButton.layer.masksToBounds = true
    }

    func updateFreeMessageCountLabel() {
        if RevenueCatManager.shared.isSubscribe {
            freeMessageCountStackView.removeFromSuperview()
        } else {
            let freeMessageCount = MessageManager.shared.freeMessageCount
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                freeMessageCountLabel.text = "You have \(freeMessageCount) free message left."
            }
        }
    }
}

//MARK: - Actions
extension AssistantsPromptEditView {
    @objc private func submitButtonTapped() {
        delegate?.assistantsPromptEditView(self, submitButtonTapped: submitButton)
    }
    
    @objc private func getPremiumButtonTapped() {
        delegate?.assistantsPromptEditView(self, getPremiumButtonTapped: getPremiumTextButton)
    }
}

//MARK: - Submit Button Visibility
extension AssistantsPromptEditView {
    func setSumbitButtonTouchability(_ isEnable: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch isEnable {
            case true:
                submitButton.isEnabled = true
            case false:
                submitButton.isEnabled = false
            }
        }
        
    }
}

//MARK: - AddSubview / Constraints
extension AssistantsPromptEditView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(submitButton)
        addSubview(assistantsPromptEditCollectionView)
        addSubview(freeMessageCountStackView)
        freeMessageCountStackView.addArrangedSubview(freeMessageCountLabel)
        freeMessageCountStackView.addArrangedSubview(getPremiumTextButton)
        
        submitButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        assistantsPromptEditCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(submitButton.snp.top).offset(-25)
        }
        
        freeMessageCountStackView.snp.makeConstraints { make in
            make.bottom.equalTo(submitButton.snp.top).offset(-5)
            make.leading.equalTo(submitButton.snp.leading).offset(6)
            make.trailing.lessThanOrEqualTo(submitButton.snp.trailing).offset(-6)
            make.height.equalTo(20)
        }
        
    }
}

