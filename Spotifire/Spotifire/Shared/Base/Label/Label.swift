//
//  Label.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

class Label: UILabel {
    @IBInspectable
    var setUnderline: Bool = false {
        didSet {
            if setUnderline {
                attributedText = NSMutableAttributedString(string: text ?? .empty).underline()
                return
            }
            attributedText = NSMutableAttributedString(string: text ?? .empty).removeUnderline()
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
        guard let font else { return }
        let newFont = font.appFont()
        self.font = newFont
    }
}
