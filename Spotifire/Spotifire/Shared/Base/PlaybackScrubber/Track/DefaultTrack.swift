//
//  DefaultTrack.swift
//  Spotifire
//
//  Created by xhieu on 4/9/24.
//

import UIKit

final class DefaultTrack: ShapeView, Track {
    // MARK: Public Properties
    var insetDistance: CGFloat = .zero
    var usableWidth: CGFloat { return frame.width - insetDistance.twice }
    var progress: CGFloat = .zero
    var shouldRoundCorners: Bool = true
    var tickMarks: [PlaybackScrubber.TickMark] = []
    var tickMarkWidth: CGFloat = 2
    var highlightSize: CGFloat = 2
    
    var elapsedTintColor: UIColor? = .white {
        didSet {
            elapsedLayer.fillColor = elapsedTintColor?.cgColor
            highlightElapsedLayer.fillColor = elapsedTintColor?.cgColor
        }
    }
    
    var remainingTintColor: UIColor? = .white.withAlphaComponent(AlphaConstant.veryLight) {
        didSet {
            shapeLayer.fillColor = remainingTintColor?.cgColor
            highlightView.shapeLayer.fillColor = remainingTintColor?.withAlphaComponent(AlphaConstant.semiOpaque).cgColor
        }
    }
    
    // MARK: Private Properties
    private let elapsedLayer = CAShapeLayer()
    private let highlightView = ShapeView()
    private let highlightElapsedLayer = CAShapeLayer()
    
    private var cornerRadius: CGFloat {
        shouldRoundCorners
        ? bounds.height.halve
        : .zero
    }
    
    override func commontInit() {
        super.commontInit()
        configureLayers()
        configureHighlightView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setPathForLayer(shapeLayer, withRect: bounds)
        
        let elapsedRect = CGRect(origin: .zero,
                                 size: CGSize(width: insetDistance + usableWidth * progress,
                                                             height: frame.height))
        
        setPathForLayer(elapsedLayer, withRect: elapsedRect)
        highlightView.frame = bounds.insetBy(dx: .zero, dy: -highlightSize)
        highlightView.layer.cornerRadius = cornerRadius + highlightSize
        
        if let path = highlightView.shapeLayer.path {
            let elapsedIntersection = elapsedRect
                .insetBy(dx: .zero, dy: -highlightSize) // highlightView is taller
                .offsetBy(dx: .zero, dy: highlightSize) // and its origin is offset
                .intersection(path.boundingBox)
            highlightElapsedLayer.path = CGPath(rect: elapsedIntersection, transform: nil)
        }
    }
    
    func highlightSectionBetween(leftTickMark: PlaybackScrubber.TickMark?, rightTickMark: PlaybackScrubber.TickMark?) {
        guard leftTickMark != nil || rightTickMark != nil else {
            clearHighlight()
            return
        }
        
        let minX: CGFloat = {
            if let leftTickMark { return rectForTickMark(leftTickMark).maxX }
            return .zero
        }()
        
        let maxX: CGFloat = {
            if let rightTickMark { return rectForTickMark(rightTickMark).minX }
            return frame.maxX
        }()
        
        let highlightRect = CGRect(x: minX, y: .zero, width: maxX - minX, height: frame.height + highlightSize.twice)
        highlightView.shapeLayer.path = CGPath(rect: highlightRect, transform: nil)
    }
    
    func highlightTrack() {
        let highlightRect = CGRect(origin: .zero,
                                   size: CGSize(width: frame.width,
                                                height: frame.height + highlightSize.twice))
        highlightView.shapeLayer.path = CGPath(rect: highlightRect, transform: nil)
    }
    
    func clearHighlight() { [highlightView.shapeLayer, highlightElapsedLayer].forEach { $0.path = nil } }
}

// MARK: - Helper Methods
extension DefaultTrack {
    private func configureLayers() {
        elapsedLayer.with {
            $0.fillRule = .evenOdd
            $0.fillColor = elapsedTintColor?.cgColor
        }
        
        shapeLayer.with {
            $0.fillRule = .evenOdd
            $0.fillColor = remainingTintColor?.cgColor
            $0.addSublayer(elapsedLayer)
        }
    }
    
    private func configureHighlightView() {
        highlightElapsedLayer.fillColor = elapsedTintColor?.cgColor
        addSubview(highlightView)
        
        highlightView.with {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
            $0.shapeLayer.fillColor = remainingTintColor?.withAlphaComponent(AlphaConstant.semiOpaque).cgColor
            $0.layer.addSublayer(highlightElapsedLayer)
        }
    }
    
    private func setPathForLayer(_ layer: CAShapeLayer, withRect rect: CGRect) {
        let path = CGMutablePath(roundedRect: rect,
                                 cornerWidth: cornerRadius,
                                 cornerHeight: cornerRadius,
                                 transform: nil)
        
        for tickMark in tickMarks where tickMark.style == .occlusion {
            let intersection = rectForTickMark(tickMark).intersection(rect)
            guard intersection != .null else { continue }
            path.addRect(intersection)
        }

        layer.path = path
    }
    
    private func rectForTickMark(_ tickMark: PlaybackScrubber.TickMark) -> CGRect {
        return CGRect(x: insetDistance + (usableWidth - tickMarkWidth) * tickMark.location,
                      y: .zero,
                      width: tickMarkWidth,
                      height: frame.height)
    }
}
