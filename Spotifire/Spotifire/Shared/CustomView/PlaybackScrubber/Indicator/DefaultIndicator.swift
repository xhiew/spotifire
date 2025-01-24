//
//  DefaultIndicator.swift
//  Spotifire
//
//  Created by xhieu on 4/9/24.
//

import UIKit

final class DefaultIndicator: ShapeView, Indicator {
    var color: UIColor? = .sWhite {
        didSet {
            shapeLayer.fillColor = color?.cgColor
        }
    }
    
    var drawPath: ((CGRect) -> CGPath) = { CGPath(ellipseIn: $0, transform: nil) } {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func commontInit() {
        super.commontInit()
        shapeLayer.fillColor = color?.cgColor
        configureShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = drawPath(bounds)
    }
    
    private func configureShadow() {
        shapeLayer.with {
            $0.shadowRadius = 3
            $0.shadowOffset = CGSize(width: 0, height: 1)
            $0.shadowColor = UIColor.black.cgColor
            $0.shadowOpacity = AlphaConstant.veryLight.float
        }
    }
}
