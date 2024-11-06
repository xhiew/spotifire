//
//  ViewDecorable.swift
//  Spotifire
//
//  Created by xhieu on 6/11/24.
//

import UIKit

protocol ViewDecorable where Self: UIView {
    func decorate(view: UIView)
}

extension UIView {
    func decorate(with decorable: ViewDecorable) {
        decorable.decorate(view: self)
    }
    
    func decorate(with decorables: [ViewDecorable]) {
        decorables.forEach { $0.decorate(view: self) }
    }
}
