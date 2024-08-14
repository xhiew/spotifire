//
//  TransitionPresenter.swift
//  Transition
//
//  Created by xhieu on 7/6/24.
//

#if os(iOS)
import UIKit

/**
 For Presentation, the object must be a UIViewController & confrom to the TransitionPresentable protocol.
 */
public typealias LayoutType = UIViewController & TransitionPresentable

/**
 A protocol for objects that will present a view controller

 - Usage:
 ```
 viewController.dropIn(viewController: presentingVC,
                                transitionType: .default,
                                sourceView: presentingVC.view,
                                sourceRect: .zero)
 ```
 */
public protocol TransitionPresenter: AnyObject {

    /**
     A flag that returns true if the current presented view controller
     */
    var isPresented: Bool { get }

    /**
     Presents a view controller that conforms to the TransitionPresentable protocol
     */
    func dropIn(_ viewController: LayoutType, transitionType: TransitionType, sourceView: UIView?, sourceRect: CGRect)

}
#endif
