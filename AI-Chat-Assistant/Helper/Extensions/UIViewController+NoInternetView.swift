//
//  UIViewController+NoInternetView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import UIKit

extension UIViewController {
    func addNoInternetView() {
        let noInternetView = NoInternetView(frame: view.bounds)
        view.addSubview(noInternetView)
    }
    
    func removeNoInternetView() {
        for subview in view.subviews {
            if let noInternetView = subview as? NoInternetView {
                noInternetView.removeFromSuperview()
            }
        }
    }
}
