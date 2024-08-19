//
//  HorizontalList.swift
//  Spotifire
//
//  Created by xhieu on 16/8/24.
//

import UIKit

class HorizontalList<CustomView>: View, Fillable where CustomView: View {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: SmartScrollView!
    
    override class var nibName: String? { return "HorizontalList" }
    
    var isAllowCenterContraint: Bool = true {
        didSet {
            centerConstraint.isActive = isAllowCenterContraint
        }
    }
    
    var itemSpacing: CGFloat = 15 {
        didSet {
            stackView.spacing = itemSpacing
        }
    }
    
    var contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15) {
        didSet {
            scrollView.contentInset = contentInset
        }
    }
    
    override func configView() {
        stackView.spacing = itemSpacing
    }
    
    func fill<Object>(with objects: [Object], onViewCreate: (Int, Object) -> CustomView) {
        clearAllItems()
        for (index, object) in objects.enumerated() {
            let view = onViewCreate(index, object)
            stackView.addArrangedSubview(view)
        }
        stackView.layoutIfNeeded()
        scrollView.contentInset = stackView.frame.width >= DeviceConstant.screenWidth ? contentInset : .zero
    }
    
    private func clearAllItems() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
