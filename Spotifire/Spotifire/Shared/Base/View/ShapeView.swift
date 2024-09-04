//
//  ShapeView.swift
//  Spotifire
//
//  Created by xhieu on 3/9/24.
//

import UIKit

class ShapeView: ViewNonNib {
    override class var layerClass: AnyClass { CAShapeLayer.self }
    var shapeLayer: CAShapeLayer { layer as! CAShapeLayer }
}
