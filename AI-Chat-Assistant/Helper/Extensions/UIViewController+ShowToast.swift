//
//  UIViewController+ShowToast.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.08.2023.
//

import UIKit

extension UIViewController {
    func showToast(message: String, image: UIImage? = nil, duration: TimeInterval = 3.0) {
        let toastView = UIView()
        toastView.backgroundColor = .black.withAlphaComponent(0.8)
        toastView.layer.cornerRadius = 10
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.tintColor = .white
            stackView.addArrangedSubview(imageView)
        }
        
        let label = UILabel()
        label.text = message
        label.textColor = UIColor.white
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
        
        toastView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalTo(toastView)
            make.leading.equalTo(toastView.snp.leading).offset(16)
            make.trailing.equalTo(toastView.snp.trailing).offset(-16)
        }
        
        self.view.addSubview(toastView)
        toastView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(self.view.snp.bottom).offset(-120)
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        }
        
    }
}
