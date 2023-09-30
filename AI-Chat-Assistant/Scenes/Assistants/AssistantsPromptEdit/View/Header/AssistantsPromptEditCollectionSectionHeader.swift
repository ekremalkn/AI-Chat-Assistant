//
//  AssistantsPromptEditCollectionSectionHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit

final class AssistantsPromptEditCollectionSectionHeader: UICollectionReusableView {
    static let identifier = "AssistantsPromptEditCollectionSectionHeader"
    
    //MARK: - Creating UI Elements
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
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
    
    func configure(assistant: TranslatedAssistant) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            sectionTitleLabel.text = assistant.title?.localizedCapitalized
        }
    }

}

//MARK: - AddSubview / Constraints
extension AssistantsPromptEditCollectionSectionHeader {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(sectionTitleLabel)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}

