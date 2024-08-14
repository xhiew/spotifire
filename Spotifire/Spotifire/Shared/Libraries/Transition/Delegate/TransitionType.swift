//
//  TransitionType.swift
//  Transition
//
//  Created by xhieu on 6/6/24.
//

import UIKit

public typealias PresentationDelegate = UIViewControllerTransitioningDelegate & UIPopoverPresentationControllerDelegate

public enum TransitionType {
    case panModal
    
    var transitioningDelegate: PresentationDelegate {
        switch self {
        case .panModal:
            return PanModalPresentationDelegate.default
        }
    }
}
