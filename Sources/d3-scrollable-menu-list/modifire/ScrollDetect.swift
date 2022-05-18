//
//  ScrollDetect.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI


///Modifier to detect scroll longevity
struct ScrollDetect: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader {
            Color.clear.preference(key: ViewOffsetKey.self,
                value: -$0.frame(in: .named("OFFSET")).origin.y)
        })
    }
}

