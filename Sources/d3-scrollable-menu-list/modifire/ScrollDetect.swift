//
//  ScrollDetect.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI


///Modifier to detect scrolling longevity
struct ScrollDetect: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader {
            Color.clear.preference(key: ViewOffsetKey.self,
                value: getY($0))
        })
    }
    
    // MARK: - Private
    
    /// Get offset
    /// - Parameter proxy: Geometry proxy
    /// - Returns: Return positive value of y offset
    private func getY(_ proxy : GeometryProxy) -> CGFloat{
        let size = proxy.frame(in: .named("OFFSET"))
        return -size.origin.y
    }
}

