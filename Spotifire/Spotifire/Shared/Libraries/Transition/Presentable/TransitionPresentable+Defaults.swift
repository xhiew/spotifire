//
//  TransitionPresentable+Defaults.swift
//  Transition
//
//  Created by xhieu on 7/6/24.
//

import UIKit

public extension TransitionPresentable where Self: UIViewController {
    var transitionDuration: Double { return 0.5 }

    var dimmedColor: UIColor { return UIColor.black.withAlphaComponent(0.7) }
    
    var isHapticFeedbackEnabled: Bool { return true }
    
    var shouldRoundCorners: Bool { return true }
    
    var cornerRadius: CGFloat { return 8.0 }
    
    var allowsDragToDismiss: Bool { return true }

    var allowsTapToDismiss: Bool { return true }
    
    var isUserInteractionEnabled: Bool { return true }
    
    var showDragIndicator: Bool { return true }

    var dragIndicatorBackgroundColor: UIColor { return UIColor.lightGray }

    func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool { return true }

    func willRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) {}

    func willDismiss() {}

    func didDismiss() {}
}
