//
//  UIButton+Ext.swift
//  Spotifire
//
//  Created by xhieu on 15/8/24.
//

import UIKit

extension UIButton {
    func setEnable(_ isEnable: Bool = true) {
        isUserInteractionEnabled = isEnable
        alpha = isEnable ? 1 : 0.5
    }
}
