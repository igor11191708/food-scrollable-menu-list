//
//  ViewOffsetKey.swift
//  
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI


/// Offset key to detect category possition
struct ViewOffsetKey: PreferenceKey {
    
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
