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


