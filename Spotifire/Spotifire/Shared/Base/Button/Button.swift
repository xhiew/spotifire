//
//  Button.swift
//  Spotifire
//
//  Created by xhieu on 15/8/24.
//

import UIKit

class Button: UIButton {
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
        setFont()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setFont()
    }
    
    private func setFont() {
        guard let font = titleLabel?.font else { return }
        let newFont = font.appFont()
        self.titleLabel?.font = newFont
    }
}
