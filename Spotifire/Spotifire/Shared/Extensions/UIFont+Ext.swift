//
//  UIFont+Ext.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

extension UIFont {
    func appFont() -> UIFont {
        let fontName = fontName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        var newFontName = FontConstant.regular
        
        if fontName.hasSuffix("thin") {
            newFontName = FontConstant.thin
        }
        
        if fontName.hasSuffix("medium") {
            newFontName = FontConstant.medium
        }
        
        if fontName.hasSuffix("semibold") {
            newFontName = FontConstant.semiBold
        }
        
        if fontName.hasSuffix("light") {
            newFontName = FontConstant.light
        }
        
        if fontName.hasSuffix("extralight") {
            newFontName = FontConstant.extraLight
        }
        
        if fontName.hasSuffix("italic") {
            newFontName = FontConstant.italic
        }
        
        if fontName.hasSuffix("extralightitalic") {
            newFontName = FontConstant.extraLightItalic
        }
        
        if fontName.hasSuffix("lightitalic") {
            newFontName = FontConstant.lightItalic
        }
        
        if fontName.hasSuffix("mediumitalic") {
            newFontName = FontConstant.mediumItalic
        }
        
        if fontName.hasSuffix("semibolditalic") {
            newFontName = FontConstant.semiBoldItalic
        }
        
        if fontName.hasSuffix("thinitalic") {
            newFontName = FontConstant.thinItalic
        }
        
        if let font = UIFont(name: newFontName, size: pointSize) { return font }
        
        return self
    }
}

extension UIFont {
    enum FontSize {
        case s11
        case s12
        case s13
        case s14
        case s15
        case s16
        case custom(size: CGFloat)
        
        public var rawValue: CGFloat {
            switch self {
            case .s11:  return 11
            case .s12:  return 12
            case .s13:  return 13
            case .s14:  return 14
            case .s15:  return 15
            case .s16:  return 16
            case .custom(let size): return size
            }
        }
    }
    
    /// eg. fontName: FontConstant.regular
    static func font(fontName: String, size: FontSize) -> UIFont {
        return UIFont(name: fontName, size: size.rawValue) ?? .systemFont(ofSize: size.rawValue)
    }
}


