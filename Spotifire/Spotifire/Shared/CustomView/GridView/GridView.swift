//
//  GridView.swift
//  Spotifire
//
//  Created by xhieu on 15/8/24.
//

import UIKit

class GridView<View>: UIStackView, Fillable where View: UIView {
    // MARK: Properties
    var numberOfColumns: Int!
    
    var items: [View] {
        arrangedSubviews.flatMap { view -> [View] in
            guard let stackView = view as? UIStackView else { return [] }
            return stackView.arrangedSubviews.filter { $0 is View } as! [View]
        }
    }
    
    var isFillEmptyView: Bool { return true }
    
    var subStackView: UIStackView {
        return UIStackView().with {
            $0.spacing = spacing
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    // MARK: Can Override Method
    func config() {
        axis = .vertical
    }
    
    func clearGridView() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: Configuration
    func fill<Object>(with objects: [Object], onViewCreate: ((_ index: Int, _ object: Object) -> View)) {
        clearGridView()
        
        for index in 0..<objects.count {
            let row = index / numberOfColumns
            
            if row == arrangedSubviews.count {
                addArrangedSubview(subStackView)
            }
            
            let object = objects[index]
            let view = onViewCreate(index, object)
            let stackView = arrangedSubviews[row] as? UIStackView
            stackView?.addArrangedSubview(view)
        }
        
        fillUpWithEmptyViews()
    }
    
    // MARK: Helpers
    private func fillUpWithEmptyViews() {
        guard isFillEmptyView else { return }
        let last = arrangedSubviews.last as? UIStackView
        
        guard
            let lastCount = last?.arrangedSubviews.count,
            numberOfColumns != lastCount
        else {
            return
        }
        
        (lastCount..<numberOfColumns).forEach { _ in
            let emptyView = UIView()
            last?.addArrangedSubview(emptyView)
        }
    }
}
