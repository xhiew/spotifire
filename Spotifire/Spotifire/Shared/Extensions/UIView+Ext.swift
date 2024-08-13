//
//  UIView+Ext.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

extension UIView {
    class var identify: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identify, bundle: nil)
    }
    
    @discardableResult
    func fromNib<T : UIView>(bundle: Bundle = .main, nibName: String? = nil) -> T? {
        let name = nibName ?? type(of: self).identify
        guard let contentView = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? T else { return nil }
        addSubViewAndFit(subView: contentView)
        return contentView
    }
    
    func fixConstraintsInView(_ container: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func addSubViewAndFit(subView: UIView) {
        addSubview(subView)
        subView.fixConstraintsInView(self)
    }
}
