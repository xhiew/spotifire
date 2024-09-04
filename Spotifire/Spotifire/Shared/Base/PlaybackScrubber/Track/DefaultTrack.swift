//
//  DefaultTrack.swift
//  Spotifire
//
//  Created by xhieu on 4/9/24.
//

import UIKit

final class DefaultTrack: ShapeView, Track {
    var insetDistance: CGFloat = .zero
    
    var usableWidth: CGFloat { return frame.width - insetDistance * 2 }
    
    var progress: Double = .zero
    
    var elapsedTintColor: UIColor? = .white {
        didSet {
            
        }
    }
    
    var remainingTintColor: UIColor? = .white.withAlphaComponent(AlphaConstant.veryLight) {
        didSet {
            
        }
    }
    
    var shouldRoundCorners: Bool = true
    
    var tickMarks: [PlaybackScrubber.TickMark] = []
    
    var tickMarkWidth: CGFloat = 2
    
    var highlightSize: CGFloat = 2
    
    func highlightSectionBetween(leftTickMark: PlaybackScrubber.TickMark?, rightTickMark: PlaybackScrubber.TickMark?) {
        
    }
    
    func clearHighlight() {
        
    }
}
