//
//  String+CopyToClipboard.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.08.2023.
//

import Foundation
import UIKit

extension String {
    enum ClipboardResult {
        case success
        case failure
    }

    func copyToClipboard(completion: @escaping (ClipboardResult) -> Void) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self
        
        if pasteboard.string == self {
            completion(.success)
        } else {
            completion(.failure)
        }
    }
}
