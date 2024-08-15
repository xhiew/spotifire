//
//  Button.swift
//  Spotifire
//
//  Created by xhieu on 15/8/24.
//

import UIKit

class Button: UIButton {
    @IBInspectable
    var setUnderline: Bool = false {
        didSet {
            if setUnderline {
                let attributedTitle = NSMutableAttributedString(string: titleLabel?.text ?? .empty).underline()
                setAttributedTitle(attributedTitle, for: .normal)
                return
            }
            let attributedTitle = NSMutableAttributedString(string: titleLabel?.text ?? .empty).removeUnderline()
            setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    func config() {
        setFont()
    }
    
    private func setFont() {
        guard let font = titleLabel?.font else { return }
        let newFont = font.appFont()
        self.titleLabel?.font = newFont
    }
}
