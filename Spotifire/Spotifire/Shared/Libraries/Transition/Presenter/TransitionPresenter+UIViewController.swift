//
//  TransitionPresenter+UIViewController.swift
//  Transition
//
//  Created by xhieu on 7/6/24.
//

#if os(iOS)
import UIKit

/**
 Extends the UIViewController to conform to the TransitionPresenter protocol
 */
extension UIViewController: TransitionPresenter {

    /**
     A flag that returns true if the topmost view controller in the navigation stack
     was presented

     - Warning: ⚠️ Calling `presentationController` in this function may cause a memory leak. ⚠️

     In most cases, this check will be used early in the view lifecycle and unfortunately,
     there's an Apple bug that causes multiple presentationControllers to be created if
     the presentationController is referenced here and called too early resulting in
     a strong reference to this view controller and in turn, creating a memory leak.
     */
    public var isPresented: Bool {
        return (transitioningDelegate as? PresentationDelegate) != nil
    }

    /**
     Configures a view controller for presentation

     - Parameters:
        - viewController: The view controller to be presented
        - transitionType: The type of transition
        - sourceView: The view containing the anchor rectangle for the popover.
        - sourceRect: The rectangle in the specified view in which to anchor the popover.

     - Note: sourceView & sourceRect are only required for presentation on an iPad.
     */
    public func dropIn(_ viewController: any LayoutType, transitionType: TransitionType = .panModal, sourceView: UIView? = nil, sourceRect: CGRect = .zero) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            viewController.with {
                $0.modalPresentationStyle = .popover
                $0.popoverPresentationController?.sourceRect = sourceRect
                $0.popoverPresentationController?.sourceView = sourceView ?? view
                $0.popoverPresentationController?.delegate = transitionType.transitioningDelegate
            }
        } else {
            viewController.with {
                $0.modalPresentationStyle = .custom
                $0.modalPresentationCapturesStatusBarAppearance = false
                $0.transitioningDelegate = transitionType.transitioningDelegate
            }
        }

        present(viewController, animated: true, completion: nil)
    }

}
#endif
