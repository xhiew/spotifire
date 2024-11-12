//
//  ExpandableViewController.swift
//  Spotifire
//
//  Created by xhieu on 30/8/24.
//

import UIKit

// MARK: - Expandable
protocol Expandable where Self: UIViewController {
    var minimisedView: UIView { get }
    var container: StickySupporting? { get set }
}

extension Expandable {
    weak var container: StickySupporting? {
        get {
            tabBarController as? StickySupporting
        }
        
        set {}
    }
}

// MARK: - ExpandaleViewController
class ExpandableViewController: ViewController {
    // MARK: Properties
    let collapsedHeight: CGFloat
    let animationDuration: TimeInterval
    
    var heightConstraint: NSLayoutConstraint!
    var isEnlarged = false
    weak var customTabBarController: StickySupporting?
    
    private let minimisedView: UIView
    private let childViewController: Expandable
    
    // MARK: Animation Properties
    lazy var isBeginningUpwards = !isEnlarged
    var runningAnimation: UIViewPropertyAnimator?
    var animationProgressWhenInterrupted: CGFloat = .zero
    
    // MARK: Initializer
    init(with childViewController: Expandable, collapsedHeight: CGFloat, animationDuration: TimeInterval) {
        self.childViewController = childViewController
        self.collapsedHeight = collapsedHeight
        self.animationDuration = animationDuration
        self.minimisedView = childViewController.minimisedView
        super.init()
    }
    
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(enlargeWithTap))
        minimisedView.addGestureRecognizer(tapGestureRecognizer)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGestureRecognizer)
        configChildViewController()
    }
    
    func expand() {
        animateTransitionIfNeeded(isEnlarging: true, duration: animationDuration)
    }
    
    func collapse() {
        animateTransitionIfNeeded(isEnlarging: false, duration: animationDuration)
    }
}

// MARK: Helper Methods
extension ExpandableViewController {
    private func configChildViewController() {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.didMove(toParent: self)
    }
    
    @objc
    private func enlargeWithTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended: animateTransitionIfNeeded(isEnlarging: !isEnlarged, duration: animationDuration)
        default: break
        }
    }
    
    @objc
    private func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            let velocity = recognizer.velocity(in: childViewController.view)
            isBeginningUpwards = isDirectionUpwards(for: velocity)
            startInteractiveTransition(isEnlarging: !isEnlarged, duration: animationDuration)
        case .changed:
            let velocity = recognizer.velocity(in: childViewController.view)
            isBeginningUpwards = isDirectionUpwards(for: velocity)
            let translation = recognizer.translation(in: childViewController.view)
            var fractionComplete = translation.y / DeviceConstant.screenHeight
            fractionComplete = isEnlarged ? fractionComplete : -fractionComplete
            if runningAnimation?.isReversed ?? false {
                fractionComplete = -fractionComplete
            }
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition(isReversed: shouldReverseAnimation())
        default:
            break
        }
    }
    
    private func shouldReverseAnimation() -> Bool {
        if isEnlarged && !isBeginningUpwards { return true }
        else if !isEnlarged && isBeginningUpwards { return true }
        return false
    }
    
    private func isDirectionUpwards(for velocity: CGPoint) -> Bool { velocity.y > .zero }
    
    private func animateTransitionIfNeeded(isEnlarging: Bool, duration: TimeInterval) {
        guard let customTabBarController,
              runningAnimation == nil,
              self.isEnlarged != isEnlarging else { return }
        
        runningAnimation = UIViewPropertyAnimator(
            duration: duration,
            dampingRatio: .one) {
                if isEnlarging {
                    self.heightConstraint.constant = DeviceConstant.screenHeight - customTabBarController.tabBar.frame.height
                    self.minimisedView.alpha = .zero
                } else {
                    self.heightConstraint.constant = self.collapsedHeight
                    self.minimisedView.alpha = .one
                }
                self.view.setNeedsLayout()
                customTabBarController.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                customTabBarController.view.layoutIfNeeded()
        }
        
        runningAnimation?.addCompletion { position in
            switch position {
            case .end:
                self.isEnlarged.toggle()
            default: break
            }
            self.runningAnimation = nil
        }
        
        runningAnimation?.startAnimation()
    }
    
    private func startInteractiveTransition(isEnlarging: Bool, duration: TimeInterval) {
        animateTransitionIfNeeded(isEnlarging: isEnlarging, duration: duration)
        runningAnimation?.pauseAnimation()
        animationProgressWhenInterrupted = runningAnimation?.fractionComplete ?? .zero
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        runningAnimation?.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
    }
    
    private func continueInteractiveTransition(isReversed: Bool) {
        runningAnimation?.isReversed = isReversed
        runningAnimation?.continueAnimation(withTimingParameters: nil, durationFactor: .zero)
    }
}
