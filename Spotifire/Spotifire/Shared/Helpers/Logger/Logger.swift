//
//  Logger.swift
//  Spotifire
//
//  Created by xhieu on 25/11/24.
//

import Foundation

@inline(__always) func xlog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
    print(items, separator: separator ,terminator: terminator)
#endif
}
