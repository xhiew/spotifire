//
//  String+Ext.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

extension String {
    static let zero = "0"
    static let one = "1"
    static let empty = ""
    static let space = " "
    
    var notEmpty: Bool { return !isEmpty }
    
    var image: UIImage? { return UIImage(named: self) }
    
    func antiSpace() -> Self { return replacingOccurrences(of: String.space, with: String.empty) }
    
    var int: Int { return Int(onlyNumber()) ?? .zero }
    
    var double: Double { return Double(onlyNumber()) ?? .zero }
    
    var bool: Bool { ["yes", "true", "y", "t", "1"].contains(lowercased()) }
    
    func onlyNumber() -> String {
        let str = replacingOccurrences(of: "[^0-9.-]", with: String.empty, options: .regularExpression, range: nil)
        return str.replacingOccurrences(of: ",", with: String.empty)
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func toDate(withFormat format: String) -> Date? {
        return DateFormatter().with {
            $0.dateFormat = format
        }.date(from: self)
    }
}
