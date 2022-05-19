//
//  ViewOffsetKey.swift
//  
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI


/// Key to detect to detect scrolling longevity
struct ViewOffsetKey: PreferenceKey {
    
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
