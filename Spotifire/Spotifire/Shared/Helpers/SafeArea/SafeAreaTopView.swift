//
//  SafeAreaTopView.swift
//  Spotifire
//
//  Created by xhieu on 15/8/24.
//

import UIKit

final class SafeAreaTopView: UIView {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var height = 20.0
        
        if let window = UIApplication.shared.delegate?.window,
           let padding = window?.safeAreaInsets.top,
           padding > .zero {
            height = padding
        }
        
        if let heightConstraint = heightConstraint {
            heightConstraint.constant = height
        } else {
            var newframe = frame
            newframe.size.height = height
            frame = newframe
        }
    }
}
