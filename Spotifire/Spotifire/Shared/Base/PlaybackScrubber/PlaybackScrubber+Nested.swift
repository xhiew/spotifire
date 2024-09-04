//
//  PlaybackScrubber+Nested.swift
//  Spotifire
//
//  Created by xhieu on 3/9/24.
//

import UIKit

// MARK: - InteractionState
extension PlaybackScrubber {
    enum InteractionState {
        /// This state indicates that scrubbing may start.
        case mayScrub(initialTouchLocation: CGPoint)
        
        /// This state represents that the user is actively scrubbing
        case scrubbing(initialPlayheadPosition: TimeInterval)
        
        /// This state represents that no interaction is currently happening.
        case none
        
        /// The minimum amount a touch must move to initiate a scrub when dragging at a point not within the playhead's touch target.
        static let minXDistanceToInitiateScrub: CGFloat = 10
    }
}

// MARK: - SectionMarker
extension PlaybackScrubber {
    struct SectionMarker {
        let time: TimeInterval
        var title: String?
        var description: String?
    }
}

// MARK: - TickMark
extension PlaybackScrubber {
    struct TickMark {
        enum Style {
            case occlusion
            case color(UIColor)
        }
        
        /// Location of tick mark on the track as a percentage of the represented duration.
        var location: Double
        
        var style: Style
    }
}
