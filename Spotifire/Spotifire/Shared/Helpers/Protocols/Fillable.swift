//
//  Fillable.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import Foundation

protocol Fillable {
    associatedtype View
    
    func fill<Object>(with objects: [Object], onViewCreate: (_ index: Int, _ object: Object) -> View)
}
