//
//  Fillable.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import Foundation

protocol Fillable {
    associatedtype View
    
    func fill<U>(with objects: [U], onViewCreate: (_ index: Int, _ object: U) -> View)
}
