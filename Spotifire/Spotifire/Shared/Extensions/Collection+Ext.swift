//
//  Collection+Ext.swift
//  Spotifire
//
//  Created by xhieu on 12/11/24.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
