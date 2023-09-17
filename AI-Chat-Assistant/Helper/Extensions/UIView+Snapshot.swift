//
//  UIView+CollectionViewContainer.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 17.09.2023.
//

import UIKit.UIView

extension UIView {
    var snapshot: UIImage? {
        var image: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext() }
        UIGraphicsEndImageContext()
        return image
    }
}


