//
//  FlexGridView.swift
//  Spotifire
//
//  Created by xhieu on 15/8/24.
//

import UIKit

final class FlexGridView<CustomView>: GridView<CustomView> where CustomView: UIView {
    private var remainingSpaceStackView: CGFloat = .zero
    
    // Tương ứng với WIDTH của FlexGridView
    private var maxSpaceStackView: CGFloat {
        return DeviceConstant.screenWidth - padding * 2
    }
    
    override func config() {
        super.config()
        remainingSpaceStackView = maxSpaceStackView
    }
    
    override var isFillEmptyView: Bool {
        return false
    }
    
    override var subStackView: UIStackView {
        return UIStackView().with {
            $0.spacing = spacing
            $0.axis = .horizontal
            $0.distribution = .fill
        }
    }
    
    private var lastSubStackView: UIStackView? {
        return arrangedSubviews.last as? UIStackView
    }
    
    // có thể điều chỉnh
    var leadingConstraintContant: CGFloat = 12
    var padding: CGFloat = 16
    //
    
    override func fill<Object>(with objects: [Object], onViewCreate: ((Int, Object) -> CustomView)) {
        clearGridView()
        for index in 0..<objects.count {
            let object = objects[index]
            let view = onViewCreate(index, object)
            
            guard let object = object as? CustomStringConvertible else {
                print("⚠️ FLEXGRIDVIEW WARNING: Object MUST conform to CustomStringConvertible")
                return
            }
            
            if arrangedSubviews.isEmpty {
                addArrangedSubview(subStackView)
            }
            
            let widthView = object.description.widthOfString(usingFont: .font(fontName: FontConstant.regular, size: .s14)) + leadingConstraintContant * 2
            
            if widthView >= maxSpaceStackView {
                if lastSubStackView?.arrangedSubviews.isEmpty == true {
                    lastSubStackView?.addArrangedSubview(view)
                } else {
                    addEmptyView(with: remainingSpaceStackView)
                    addArrangedSubview(subStackView)
                    lastSubStackView?.addArrangedSubview(view)
                    remainingSpaceStackView = maxSpaceStackView
                }
                addArrangedSubview(subStackView)
                continue
            }
            
            remainingSpaceStackView -= widthView + spacing
            
            if remainingSpaceStackView < .zero {
                addEmptyView(with: remainingSpaceStackView + widthView + spacing)
                addArrangedSubview(subStackView)
                remainingSpaceStackView = maxSpaceStackView - widthView - spacing
            }
            
            lastSubStackView?.addArrangedSubview(view)
            
            if index == objects.count - 1, remainingSpaceStackView > .zero {
                addEmptyView(with: remainingSpaceStackView)
            }
        }
    }
    
    private func addEmptyView(with width: CGFloat) {
        let view = UIView().with {
            $0.frame = .init(origin: .init(x: 0, y: 0), size: .init(width: width, height: .zero))
        }
        lastSubStackView?.addArrangedSubview(view)
    }
}
