//
//  AssistantsPromptEditCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit

protocol AssistantsPromptEditCollectionCellDelegate: AnyObject {
    func assistantsPromptEditCollectionCell(_ cell: AssistantsPromptEditCollectionCell, promptEditButtonTapped textView: UITextView)
}

final class AssistantsPromptEditCollectionCell: UICollectionViewCell {
    static let identifier = "AssistantsPromptEditCollectionCell"
    
    //MARK: - Creating UI Elements
    lazy var promptTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.isEditable = false
        textView.isSelectable = true
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.contentInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        return textView
    }()
    
    lazy var promptEditButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Prompt", for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        button.addTarget(self, action: #selector(promptEditButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Rerences
    weak var delegate: AssistantsPromptEditCollectionCellDelegate?
    
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
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        promptEditButton.layer.cornerRadius = 8
        promptEditButton.layer.masksToBounds = true
    }
    
    func configure(with assistant: Assistant) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            promptTextView.text = assistant.prompt
        }
    }
}

//MARK: - Action
extension AssistantsPromptEditCollectionCell {
    @objc private func promptEditButtonTapped() {
        delegate?.assistantsPromptEditCollectionCell(self, promptEditButtonTapped: promptTextView)
    }
}

//MARK: - AddSubview / Constraints
extension AssistantsPromptEditCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(promptTextView)
        addSubview(promptEditButton)
        
        promptEditButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.35)
            make.height.equalTo(40)
        }
        
        promptTextView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(promptEditButton.snp.top).offset(-20)
        }
        
    }
}


