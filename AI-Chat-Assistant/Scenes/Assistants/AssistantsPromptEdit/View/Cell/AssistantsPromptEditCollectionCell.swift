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
        textView.isSelectable = false
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.contentInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        textView.dataDetectorTypes = .link
        return textView
    }()
    
    lazy var promptEditButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Prompt".localized(), for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 1.5
        button.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        button.addTarget(self, action: #selector(promptEditButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var promptEditInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "info.circle.fill"), for: .normal)
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    //MARK: - Rerences
    weak var delegate: AssistantsPromptEditCollectionCellDelegate?
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setPromptEditInfoButton()
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
    
    private func setPromptEditInfoButton() {
        let understood = UIAction(title: "Understood".localized(), image: .init(systemName: "hand.thumbsup.fill"), handler: { _ in
            
        })
            
        let infoMenu = UIMenu(title: "When you make changes according to your own preference within the prompt, the quality of the response improves.".localized(), children: [understood])
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            promptEditInfoButton.menu = infoMenu
        }
    }
}

//MARK: - Animation
extension AssistantsPromptEditCollectionCell {
    func highlightEditButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            let shake = CABasicAnimation(keyPath: "position")
            shake.duration = 0.1
            shake.repeatCount = 4
            shake.autoreverses = true
            shake.fromValue = NSValue(cgPoint: CGPoint(x: promptEditButton.center.x - 5, y: promptEditButton.center.y))
            shake.toValue = NSValue(cgPoint: CGPoint(x: promptEditButton.center.x + 5, y: promptEditButton.center.y))
            promptEditButton.layer.add(shake, forKey: "position")
        }
    }
}

//MARK: - AddSubview / Constraints
extension AssistantsPromptEditCollectionCell {
    private func setupViews() {
        backgroundColor = .cellBackground
        addSubview(promptTextView)
        addSubview(promptEditButton)
        addSubview(promptEditInfoButton)
        promptEditButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.width.greaterThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.35)
            make.height.equalTo(40)
        }
        
        promptEditInfoButton.snp.makeConstraints { make in
            make.centerY.equalTo(promptEditButton.snp.centerY)
            make.trailing.equalTo(promptEditButton.snp.leading).offset(-10)
            make.height.width.equalTo(promptEditButton.snp.height)
        }
        
        promptTextView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(promptEditButton.snp.top).offset(-20)
        }
        
    }
}


