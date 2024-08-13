//
//  Dequeueable+Ext.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

// MARK: UITableView
extension UITableView {
    func dequeueCell<T: UITableViewCell>(_ anyClass: T.Type, at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: anyClass.identify, for: indexPath) as? T else { return T() }
        return cell
    }
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ anyClass: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: anyClass.identify) as? T else { return T() }
        return view
    }
    
    func registerCell<T: UITableViewCell>(_ anyClass: T.Type, nibType: Bool = true) {
        return nibType
        ? register(anyClass.nib, forCellReuseIdentifier: anyClass.identify)
        : register(anyClass, forCellReuseIdentifier: anyClass.identify)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ anyClass: T.Type, nibType: Bool = true) {
        return nibType
        ? register(anyClass.nib, forHeaderFooterViewReuseIdentifier: anyClass.identify)
        : register(anyClass, forHeaderFooterViewReuseIdentifier: anyClass.identify)
    }
}

// MARK: UICollectionView
extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(_ anyClass: T.Type, at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: anyClass.identify, for: indexPath) as? T else { return T() }
        return cell
    }
    
    func registerCell<T: UICollectionViewCell>(_ anyClass: T.Type, nibType: Bool = true) {
        return nibType
        ? register(anyClass.nib, forCellWithReuseIdentifier: anyClass.identify)
        : register(anyClass, forCellWithReuseIdentifier: anyClass.identify)
    }
}
