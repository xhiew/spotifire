//
//  SafeAreaBottomView.swift
//  Spotifire
//
//  Created by xhieu on 15/8/24.
//

import UIKit

final class SafeAreaBottomView: UIView {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var nHeight: CGFloat = .zero
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let heightConstraint = heightConstraint {
            nHeight = heightConstraint.constant
        } else {
            nHeight = frame.size.height
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var height = nHeight
        
        if let window = UIApplication.shared.delegate?.window,
           let padding = window?.safeAreaInsets.bottom,
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
