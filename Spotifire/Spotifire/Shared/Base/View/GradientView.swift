//
//  GradientView.swift
//  Spotifire
//
//  Created by xhieu on 2/9/24.
//

import UIKit

class GradientView: UIView {
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    @IBInspectable
    var startColor: UIColor = .baseWhite {
        didSet {
            colors = (startColor, endColor)
        }
    }
    
    @IBInspectable
    var endColor: UIColor = .baseWhite {
        didSet {
            colors = (startColor, endColor)
        }
    }
    
    var colors: (start: UIColor, end: UIColor)? {
        didSet { updateLayer() }
    }
    
    private func updateLayer() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = colors.map { [$0.start.cgColor, $0.end.cgColor] }
    }
}
