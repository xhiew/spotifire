//
//  KeyboardHelper.swift
//  Spotifire
//
//  Created by xhieu on 14/8/24.
//

import UIKit

protocol KeyboardHelperDelegate: AnyObject {
    func keyboardChanged(size: CGSize, animationDuration: TimeInterval, isHidden: Bool)
}

class KeyboardHelper {
    private weak var delegate: KeyboardHelperDelegate?

    init() {}

    func register(target: KeyboardHelperDelegate) {
        delegate = target
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHelper.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHelper.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unregister() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        let duration = TimeInterval(exactly: keyboardAnimationDuration) ?? 0
        delegate?.keyboardChanged(size: keyboardFrame.size, animationDuration: duration, isHidden: false)
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        let duration = TimeInterval(exactly: keyboardAnimationDuration ?? 0) ?? 0
        delegate?.keyboardChanged(size: CGSize.zero, animationDuration: duration, isHidden: true)
    }
}
