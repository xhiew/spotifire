//
//  PanModalPresentable+Defaults.swift
//  PanModal
//
//  Copyright © 2018 Tiny Speck, Inc. All rights reserved.
//

#if os(iOS)
import UIKit

/**
 Default values for the PanModalPresentable.
 */
public extension PanModalPresentable where Self: UIViewController {
    var panScrollable: UIScrollView? { return nil }
    
    var topOffset: CGFloat { return topSafeArea + 21.0 }
    
    var shortFormHeight: PanModalHeight { return longFormHeight }
    
    var longFormHeight: PanModalHeight {
        guard let scrollView = panScrollable else { return .maxHeight }
        
        // called once during presentation and stored
        scrollView.layoutIfNeeded()
        return .contentHeight(scrollView.contentSize.height)
    }
    
    var springDamping: CGFloat { return 0.8 }
    
    var transitionAnimationOptions: UIView.AnimationOptions {
        return [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState]
    }
    
    var scrollIndicatorInsets: UIEdgeInsets {
        let top = shouldRoundCorners ? cornerRadius : 0
        return UIEdgeInsets(top: CGFloat(top), left: 0, bottom: bottomSafeArea, right: 0)
    }
    
    var anchorModalToLongForm: Bool { return true }
    
    var allowsExtendedPanScrolling: Bool {
        guard let scrollView = panScrollable else { return false }
        scrollView.layoutIfNeeded()
        return scrollView.contentSize.height > (scrollView.frame.height - bottomSafeArea)
    }
    
    func shouldPrioritize(panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool { return false }
    
    func shouldTransition(to state: PanModalPresentationController.PresentationState) -> Bool { return true }
    
    func willTransition(to state: PanModalPresentationController.PresentationState) {}
}
#endif
