//
//  AKA.swift
//  Spotifire
//
//  Created by xhieu on 2/9/24.
//

import Foundation

// MARK: Also Known As
public protocol AKA {}

public extension AKA where Self: Any {
    static var aka: String {
        let name = String(describing: self)
        if let simpleName = name.split(separator: "<").first { return String(simpleName) }
        return name
    }
}

extension NSObject: AKA {}
