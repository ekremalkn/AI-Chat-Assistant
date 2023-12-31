//
//  SuggestionsChatCollectionHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import UIKit

final class SuggestionsChatCollectionHeader: UICollectionReusableView {
    static let identifier = "SuggestionsChatCollectionHeader"
    
    //MARK: - Creating UI Elements
    private lazy var gptModelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .main
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .main.withAlphaComponent(0.5)
        return view
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(gptModel: GPTModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            gptModelLabel.text = "Model: ChatGPT (\(gptModel.modelUIName))"
        }
    }
}

//MARK: - AddSubview / Constraints
extension SuggestionsChatCollectionHeader {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(seperatorView)
        addSubview(gptModelLabel)
        
        
        seperatorView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width)
            make.height.equalTo(0.5)
        }
        
        gptModelLabel.snp.makeConstraints { make in
            make.bottom.equalTo(seperatorView.snp.bottom).offset(-10)
            make.centerX.equalTo(seperatorView.snp.centerX)
            make.top.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.top)
            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width).offset(-40)
        }

    }
}

