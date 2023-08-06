//
//  UIViewController+KeyboardWillShow.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit.UIViewController

//MARK: - Keyboard Will Show
extension UIViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextView = UIResponder.currentFirst() as? UITextView else { return }
        
        
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextViewFrame = view.convert(currentTextView.frame, from: currentTextView.superview)
        let textViewBottomY = convertedTextViewFrame.origin.y + convertedTextViewFrame.size.height
        
        // if textView bottom is below keyboard bottom - bump the frame up
        if textViewBottomY > keyboardTopY {
            let textBoxY = convertedTextViewFrame.origin.y
            let newFrameY = ((textBoxY - keyboardTopY / 2) - 85) * -1
            view.frame.origin.y = newFrameY
//            navigationController?.navigationBar.isHidden = true
        }
        
        print("foo - currentTextFieldFrame: \(currentTextView.frame)")
        print("foo - convertedTextFieldFrame: \(convertedTextViewFrame)")
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
//        navigationController?.navigationBar.isHidden = false
    }
    
}

//MARK: - Hide Keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIResponder {
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    /// Finds the current first responder
    /// - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap() {
        Static.responder = self
    }
}

