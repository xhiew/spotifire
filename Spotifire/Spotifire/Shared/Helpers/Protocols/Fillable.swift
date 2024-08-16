//
//  Fillable.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import Foundation

protocol Fillable {
    associatedtype CustomView
    
    func fill<Object>(with objects: [Object], onViewCreate: (_ index: Int, _ object: Object) -> CustomView)
}
