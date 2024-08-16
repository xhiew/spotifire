//
//  HorizontalList.swift
//  Spotifire
//
//  Created by xhieu on 16/8/24.
//

import UIKit

class HorizontalList<CustomView>: View, Fillable where CustomView: View {
    func fill<Object>(with objects: [Object], onViewCreate: (Int, Object) -> CustomView) {
        
    }
}
