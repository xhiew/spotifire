//
//  With.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import Foundation

public protocol With {}

public extension With where Self: Any {
    @discardableResult
    func with(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: With {}
