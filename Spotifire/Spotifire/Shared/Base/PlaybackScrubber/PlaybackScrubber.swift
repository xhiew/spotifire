//
//  PlaybackScrubber.swift
//  Spotifire
//
//  Created by xhieu on 3/9/24.
//

import UIKit

// MARK: - PlaybackScrubberDelegate
protocol PlaybackScrubberDelegate: AnyObject {
    func playbackScrubber(_ playbackScrubber: PlaybackScrubber, didBeginScrubbingAtTime time: TimeInterval)
    func playbackScrubber(_ playbackScrubber: PlaybackScrubber, didScrubToTime time: TimeInterval)
    func playbackScrubber(_ playbackScrubber: PlaybackScrubber, didEndScrubbingAtTime time: TimeInterval)
}

// MARK: - PlaybackScrubber
@IBDesignable
class PlaybackScrubber: UIControl {
    // MARK: Public Properties
    weak var delegate: PlaybackScrubberDelegate?
    
//    var track: ShapeView = Track()
//    var indicator: ShapeView = Indicator()
    
    /// The overall duration of the media this scrubber represents in seconds.
    var duration: TimeInterval = .zero {
        didSet {
            playheadPosition = clampedPlayheadPosition
            setNeedsLayout()
        }
    }
    
    /// The current playback time of the media in seconds.
    /// This value is always clamped to the range of `.zero...duration`.
    /// The default value of this property is 0.0.
    var currentTime: TimeInterval {
        set {
            switch interactionState {
            case .scrubbing: return // We don't want to allow setting the playhead position while the user is actively scrubbing. return
            case .mayScrub, .none: break
            }
            playheadPosition = newValue
        }
        
        get { playheadPosition }
    }
    
    /// default is true.
    var isHapticFeedbackEnabled: Bool = true
    
    /// An ordered array of markers that denote sections within the media. These markers will be indicated visually,
    /// and haptic feedback (if enabled) will let the user know when they have changed sections while scrubbing.
    /// Markers will be sorted by time when setting this property.
    var sectionMarkers: [SectionMarker] {
        set { sortedSectionMarkers = newValue.sorted(by: { $0.time < $1.time }) }
        get { sortedSectionMarkers }
    }
    
    /// The height of the track that the playhead moves along.
    /// The default value of this property is 4 pt.
    var trackHeight: CGFloat = 4
    
    /// True if the corners of the track and the elapsed time fill should be rounded, false otherwise.
    /// The default value of this property is true.
//    public var shouldRoundTrackCorners: Bool {
//        set { track.shouldRoundCorners = newValue }
//        get { track.shouldRoundCorners }
//    }
    
    // MARK: Private Properties
    private var interactionState: InteractionState = .none
    
    /// The location of the playhead in seconds.
    private var playheadPosition: TimeInterval {
        set { clampedPlayheadPosition = min(duration, max(.zero, newValue)) }
        get { clampedPlayheadPosition }
    }
    
    /// Do not set this value directly, instead use `playheadPosition` which clamps new values based on the current duration.
    private var clampedPlayheadPosition: TimeInterval = .zero {
        didSet {
            setNeedsLayout()
            sectionMarkerIndex = indexOfSectionMarkerImmediatelyPreceding(time: clampedPlayheadPosition)
        }
    }
    
    /// The index of the section marker that immediately precedes the current playhead location,
    /// or nil if no marker has a time less than the playhead position or there are no section markers.
    private var sectionMarkerIndex: Int?
    
    /// Do not set this value directly, instead use `sectionMarkers` which sorts new values based on their time.
    private var sortedSectionMarkers: [SectionMarker] = [] {
        didSet {
//            updateTrackTickMarks()
//            track.setNeedsLayout()
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

// MARK: Helper Methods
extension PlaybackScrubber {
    private func commonInit() {
        
    }
    
    private func indexOfSectionMarkerImmediatelyPreceding(time: TimeInterval) -> Int? {
        return sectionMarkers.lastIndex(where: { $0.time < time })
    }
}
