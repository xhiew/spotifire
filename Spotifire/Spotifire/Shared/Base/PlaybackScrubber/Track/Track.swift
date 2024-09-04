//
//  Track.swift
//  Spotifire
//
//  Created by xhieu on 4/9/24.
//

import UIKit

protocol Track: AnyObject {
    /// The width of the portion of the track at either end that is not usable due to the width of the playhead.
    var insetDistance: CGFloat { get set }
    
    /// The width portion of the track that is usable, calculated based on the width of the track and the `insetDistance`.
    var usableWidth: CGFloat { get }
    
    /// The percentage of progress to indicate visually via the `elapsedTintColor`.
    /// Must be in the range of 0...1
    var progress: Double { get set }
    
    /// The color of the portion of the track that represents the elapsed time.
    var elapsedTintColor: UIColor? { get set }
    
    /// The color of the portion of the track that represents the remaining time.
    var remainingTintColor: UIColor? { get set }
    
    /// True if the corners of the track and the elapsed time fill should be rounded, false otherwise.
    var shouldRoundCorners: Bool { get set }
    
    /// An ordered array of tick marks to be represented on the track visually.
    var tickMarks: [PlaybackScrubber.TickMark] { get set }
    
    /// The width of the tick marks to be displayed on the track.
    var tickMarkWidth: CGFloat { get set }
    
    /// The amount that the track should grow vertically in each direction when being highlighted.
    var highlightSize: CGFloat { get set }
    
    /// Visually highlights a section of track between two tick marks or one edge of the track (represented by passing in nil) and a tick mark.
    /// Passing in nil for for both tick marks will result in the highlight being cleared.
    func highlightSectionBetween(leftTickMark: PlaybackScrubber.TickMark?, rightTickMark: PlaybackScrubber.TickMark?)
    
    /// Clears any highlight previously set by `highlightSectionBetween(leftTickMark:rightTickMark:)`.
    func clearHighlight()
}
