//
//  SettingsCollectionSectionHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import UIKit

final class SettingsCollectionSectionHeader: UICollectionReusableView {
    static let identifier = "SettingsCollectionSectionHeader"
    
    //MARK: - Creating UI Elements
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 20, weight: .medium)
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
    
    func configure(with sectionCategory: SettingsSectionCategory) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            sectionTitleLabel.text = sectionCategory.sectionTitle
        }
    }
    
}

//MARK: - AddSubview / Constraints
extension SettingsCollectionSectionHeader {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(sectionTitleLabel)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height)
        }
    }
}

