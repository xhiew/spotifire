//
//  NSMutableAttributedString+Ext.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

extension NSMutableAttributedString {
    func changeTextColor(stringToColor: String, color: UIColor) -> Self {
        let range = (self.string as NSString).range(of: stringToColor)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return self
    }
    
    func changeFont(stringToColor: String, font: UIFont) -> Self {
        let range = (self.string as NSString).range(of: stringToColor)
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        return self
    }
    
    func changeLineSpacing(lineSpacing: CGFloat) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: .zero, length: length))
        return self
    }
    
    func changeLineHeight(value: CGFloat) -> Self {
        let paragraphStyle = NSMutableParagraphStyle().with {
            $0.minimumLineHeight = value
            $0.maximumLineHeight = value
        }
        
        addAttribute(.paragraphStyle,
                     value: paragraphStyle,
                     range: .init(location: .zero, length: length))
        
        return self
    }
    
    func underline(_ subText: String? = nil, underlineStyle: NSUnderlineStyle = .single) -> Self {
        let range: NSRange
        
        if let subText = subText, let textRange = string.range(of: subText) {
            range = NSRange(textRange, in: string)
        } else {
            range = NSRange(location: .zero, length: length)
        }
        
        addAttribute(.underlineStyle, value: underlineStyle.rawValue, range: range)
        
        return self
    }
    
    func removeUnderline(from subText: String? = nil) -> Self {
        let range: NSRange
        
        if let subText = subText, let textRange = string.range(of: subText) {
            range = NSRange(textRange, in: string)
        } else {
            range = NSRange(location: .zero, length: length)
        }
        
        removeAttribute(.underlineStyle, range: range)
        
        return self
    }
}
