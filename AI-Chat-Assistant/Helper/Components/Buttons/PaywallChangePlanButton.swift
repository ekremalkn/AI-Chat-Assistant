//
//  PaywallChangePlanButton.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 29.09.2023.
//

import UIKit

final class PaywallChangePlanButton: UIButton {

    //MARK: - Creating UI Elements
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        return view
    }()

    private lazy var buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .main
        label.text = "Change Plan"
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
extension PaywallChangePlanButton {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(bottomLine)
        
        bottomLine.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(2.5)
        }
        
//        buttonTitleLabel.snp.makeConstraints { make in
//            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
//            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height).offset(-2.5)
//            make.width.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.width)
//        }
    }
}
