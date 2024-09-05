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
    var progress: Double = .zero
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
        
    }
    
    func highlightSectionBetween(leftTickMark: PlaybackScrubber.TickMark?, rightTickMark: PlaybackScrubber.TickMark?) {
        
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
}
