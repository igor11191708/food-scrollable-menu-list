//
//  OffsetCategoryKey.swift
//  
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI

/// Key to detect category possition
struct OffsetCategoryKey: PreferenceKey {
    
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
