//
//  ChatHistoryCollectionEmptyHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import UIKit
import Lottie

final class ChatHistoryCollectionEmptyHeader: UICollectionReusableView {
    static let identifier = "ChatHistoryCollectionEmptyHeader"
    
    //MARK: - Crating UI Elements
    private lazy var emptyChatHistoryAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "EmptyChatHistoryAnimation")
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No Chat History".localized()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "After creating any chat, you will see the chat you created here.".localized()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white.withAlphaComponent(0.5)
        label.numberOfLines = 0
        return label
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
extension ChatHistoryCollectionEmptyHeader {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(emptyChatHistoryAnimationView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subTitleLabel)
        
        emptyChatHistoryAnimationView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(emptyChatHistoryAnimationView.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalTo(emptyChatHistoryAnimationView)
        }
    }
}
