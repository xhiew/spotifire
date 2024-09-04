//
//  View.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

// MARK: - View With Load Nib
class View: UIView {
    class var bundle: Bundle { .main }
    class var nibName: String? { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commontInit()
    }

    private func commontInit() {
        fromNib(bundle: Self.bundle, nibName: Self.nibName)
        configView()
    }
    
    func configView() {}
}

// MARK: - View Without Load Nib
class ViewNonNib: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commontInit()
    }

    func commontInit() {}
}
