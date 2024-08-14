//
//  TransitionPresentable.swift
//  Transition
//
//  Created by xhieu on 7/6/24.
//

#if os(iOS)
import UIKit

public protocol TransitionPresentable: AnyObject {
    
    /**
     The transitionDuration value is used to set the speed of animation during a transition,
     including initial presentation.
    */
    var transitionDuration: Double { get }
    
    /**
     The background view color.

     - Note: This is only utilized at the very start of the transition.
    */
    var dimmedColor: UIColor { get }
    
    /**
     A flag to determine if haptic feedback should be enabled during presentation.
     */
    var isHapticFeedbackEnabled: Bool { get }
    
    /**
     A flag to determine if the top corners should be rounded.
     */
    var shouldRoundCorners: Bool { get }
    
    /**
     The corner radius used when `shouldRoundCorners` is enabled.
     */
    var cornerRadius: CGFloat { get }
    
    /**
     A flag to determine if dismissal should be initiated when swiping down on the presented view.

     Return false to fallback to the short form state instead of dismissing.
     */
    var allowsDragToDismiss: Bool { get }
    
    /**
     A flag to determine if dismissal should be initiated when tapping on the dimmed background view.
     */
    var allowsTapToDismiss: Bool { get }
    
    /**
     A flag to toggle user interactions on the container view.

     - Note: Return false to forward touches to the presentingViewController.
    */
    var isUserInteractionEnabled: Bool { get }
    
    /**
     A flag to determine if a drag indicator should be shown
     above the pan modal container view.
     */
    var showDragIndicator: Bool { get }
    
    /**
     The drag indicator view color.
    */
    var dragIndicatorBackgroundColor: UIColor { get }
    
    /**
     Asks the delegate if the pan modal should respond to the pan modal gesture recognizer.
     
     Return false to disable movement on the pan modal but maintain gestures on the presented view.
     */
    func shouldRespond(to panGestureRecognizer: UIPanGestureRecognizer) -> Bool
    
    /**
     Notifies the delegate when the pan modal gesture recognizer state is either
     `began` or `changed`. This method gives the delegate a chance to prepare
     for the gesture recognizer state change.

     For example, when the pan modal view is about to scroll.
     */
    func willRespond(to panModalGestureRecognizer: UIPanGestureRecognizer)
    
    /**
     Notifies the delegate that the modal is about to be dismissed.
     */
    func willDismiss()
    
    /**
     Notifies the delegate after the modal is dismissed.
     */
    func didDismiss()
}
#endif
