//
//  CGFloat+Ext.swift
//  Spotifire
//
//  Created by xhieu on 30/8/24.
//

import Foundation

extension CGFloat {
    /// Value is 1.0
    static let one = 1.0
    
    /// Half of the current value.
    var halve: CGFloat { self / 2 }
    
    /// Twice the current value.
    var twice: CGFloat { self * 2 }
    
    /// Type casting to Float.
    var float: Float { return Float(self) }
}
