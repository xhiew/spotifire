//
//  PanModalPresentable+LayoutHelpers.swift
//  PanModal
//
//  Copyright © 2018 Tiny Speck, Inc. All rights reserved.
//

#if os(iOS)
import UIKit

/**
 ⚠️ [Internal Only] ⚠️
 Helper extensions that handle layout in the PanModalPresentationController
 */
extension PanModalPresentable where Self: UIViewController {

    /**
     Cast the presentation controller to PanModalPresentationController
     so we can access PanModalPresentationController properties and methods
     */
    var presentedVC: PanModalPresentationController? {
        return presentationController as? PanModalPresentationController
    }

    /**
     Length of the top layout guide of the presenting view controller.
     Gives us the safe area inset from the top.
     */
    var topSafeArea: CGFloat {

        guard let rootVC = rootViewController
        else { return .zero }

        return rootVC.view.safeAreaInsets.top
    }

    /**
     Length of the bottom layout guide of the presenting view controller.
     Gives us the safe area inset from the bottom.
     */
    var bottomSafeArea: CGFloat {

       guard let rootVC = rootViewController
            else { return 0}

        return rootVC.view.safeAreaInsets.bottom
    }

    /**
     Returns the short form Y position

     - Note: If voiceover is on, the `longFormYPos` is returned.
     We do not support short form when voiceover is on as it would make it difficult for user to navigate.
     */
    var shortFormYPos: CGFloat {
        guard !UIAccessibility.isVoiceOverRunning
            else { return longFormYPos }

        let shortFormYPos = topMargin(from: shortFormHeight) + topOffset

        // shortForm shouldn't exceed longForm
        return max(shortFormYPos, longFormYPos)
    }

    /**
     Returns the long form Y position

     - Note: We cap this value to the max possible height
     to ensure content is not rendered outside of the view bounds
     */
    var longFormYPos: CGFloat {
        return max(topMargin(from: longFormHeight), topMargin(from: .maxHeight)) + topOffset
    }

    /**
     Use the container view for relative positioning as this view's frame
     is adjusted in PanModalPresentationController
     */
    var bottomYPos: CGFloat {
        guard let container = presentedVC?.containerView
            else { return view.bounds.height }

        return container.bounds.size.height - topOffset
    }

    /**
     Converts a given pan modal height value into a y position value
     calculated from top of view
     */
    func topMargin(from: PanModalHeight) -> CGFloat {
        switch from {
        case .maxHeight:
            return 0.0
        case .maxHeightWithTopInset(let inset):
            return inset
        case .contentHeight(let height):
            return bottomYPos - (height + bottomSafeArea)
        case .contentHeightIgnoringSafeArea(let height):
            return bottomYPos - height
        case .intrinsicHeight:
            view.layoutIfNeeded()
            let targetSize = CGSize(width: (presentedVC?.containerView?.bounds ?? UIScreen.main.bounds).width,
                                    height: UIView.layoutFittingCompressedSize.height)
            let intrinsicHeight = view.systemLayoutSizeFitting(targetSize).height
            return bottomYPos - (intrinsicHeight + bottomSafeArea)
        }
    }

    private var rootViewController: UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        return windowScene.windows.filter { $0.isKeyWindow }.first?.rootViewController
    }

}
#endif
