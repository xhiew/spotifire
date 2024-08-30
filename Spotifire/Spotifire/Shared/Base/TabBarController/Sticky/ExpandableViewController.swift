//
//  ExpandableViewController.swift
//  Spotifire
//
//  Created by xhieu on 30/8/24.
//

import UIKit

// MARK: - Expandable
protocol Expandable where Self: ViewController {
    var minimisedView: View { get }
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
    
    private let minimisedView: View
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
        super.init(nibName: nil, bundle: nil)
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
    @objc
    private func enlargeWithTap(recognizer: UITapGestureRecognizer) {
        
    }
    
    @objc
    private func handlePan(recognizer: UIPanGestureRecognizer) {
        
    }
    
    private func configChildViewController() {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.didMove(toParent: self)
    }
    
    private func animateTransitionIfNeeded(isEnlarging: Bool, duration: TimeInterval) {
        guard let customTabBarController,
              runningAnimation == nil,
              self.isEnlarged != isEnlarging else { return }
        
        runningAnimation = UIViewPropertyAnimator(
            duration: duration,
            dampingRatio: 1) {
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
}
