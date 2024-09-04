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
}
