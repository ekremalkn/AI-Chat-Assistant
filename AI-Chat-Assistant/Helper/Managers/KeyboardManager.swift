//
//  KeyboardManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import Foundation
import IQKeyboardManagerSwift

final class KeyboardManager {
    static let shared = KeyboardManager()
    
    private init () { }
    
    func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.keyboardAppearance = .dark
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20
    }
    
    func setKeyboardToolbar(enable: Bool, doneButtonText: String? = nil) {
        IQKeyboardManager.shared.enableAutoToolbar = enable
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = doneButtonText
    }
}
