//
//  UIViewController+CopyToClipboard.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 17.09.2023.
//

import UIKit.UIViewController

extension UIViewController {
    func copyTextToClipboard(copiedText: String) {
        copiedText.copyToClipboard { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                showToast(message: "Copied to clipboard", image: .init(systemName: "doc.on.doc.fill"), duration: 1.5)
            case .failure:
                showToast(message: "Failed to copy to clipboard", image: .init(systemName: "doc.on.doc.fill"), duration: 1.5)
            }
        }
    }
}
