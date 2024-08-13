//
//  Font+Constant.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import Foundation

struct FontConstant {
    static private let notoSans = "NotoSans-"
    static let italic = "Italic"
    static let extraLight = notoSans + "ExtraLight"
    static let light = notoSans + "Light"
    static let medium = notoSans + "Medium"
    static let regular = notoSans + "Regular"
    static let semiBold = notoSans + "SemiBold"
    static let thin = notoSans + "Thin"
    static let extraLightItalic = notoSans + extraLight + italic
    static let lightItalic = notoSans + light + italic
    static let mediumItalic = notoSans + medium + italic
    static let semiBoldItalic = notoSans + semiBold + italic
    static let thinItalic = notoSans + thin + italic
}
