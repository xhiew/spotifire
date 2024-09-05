//
//  Indicator.swift
//  Spotifire
//
//  Created by xhieu on 4/9/24.
//

import UIKit

protocol Indicator: AnyObject {
    /// The fill color of the playhead. Defaults to a very light gray.
    var color: UIColor? { get set }
    
    var drawPath: ((CGRect) -> CGPath) { get set }
}
