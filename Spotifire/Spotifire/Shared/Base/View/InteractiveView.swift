//
//  InteractiveView.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

final class InteractiveView: View {
    private let isEnabledAllowsUserInteractionWhileHighlightingCard = true
    private let cardHighlightedFactor: CGFloat = 0.96
    
    var disabledHighlightedAnimation = false
    
    override func configView() { super.configView() }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        if disabledHighlightedAnimation {
            return
        }
        
        let animationOptions: UIView.AnimationOptions = isEnabledAllowsUserInteractionWhileHighlightingCard
        ? [.allowUserInteraction] 
        : []
        
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                self.transform = .init(scaleX: self.cardHighlightedFactor,
                                       y: self.cardHighlightedFactor)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                self.transform = .identity
            }, completion: completion)
        }
    }
}
