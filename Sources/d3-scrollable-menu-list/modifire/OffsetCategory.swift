//
//  OffsetCategory.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI
import d3_menu_bar


/// Modifier to detect category possition
struct OffsetCategory<C: IMenuItem>: ViewModifier {

    // MARK: - Cgf

    /// Menu category
    let category: C

    ///Selected menu
    @Binding var selected: C?

    /// Suspend scroll action, true - to suspend
    @Binding var suspend: Bool
    
    /// Available visible size for scrollview
    let size: CGSize

    // MARK: - Life circle

    /// The content and behavior of the view
    func body(content: Content) -> some View {
        content
            .overlay {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: OffsetCategoryKey.self, value: proxy.frame(in: .named("OFFSET")))
            }
        }
            .onPreferenceChange(OffsetCategoryKey.self) { rect in
            let minY = rect.minY

            let condition = minY >= 0 && minY < size.height &&
                selected != category &&
                !suspend

            if condition {
                select(category)
            } else {
                let nextCondition = minY > size.height &&
                    selected == category &&
                    !suspend
                if nextCondition {
                    select(category.previous())
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func select(_ category: C) {
        withAnimation {
            selected = category
        }
    }
}


fileprivate extension IMenuItem {
    
    /// Get previous element
    /// - Returns: previous element or current if previous does not exist
    func previous() -> Self {
        let all = Self.allCases
        let startIndex = all.startIndex
        guard let idx = all.firstIndex(of: self) else{
            return self
        }
        let previous = all.index(idx, offsetBy: -1)
        return previous < startIndex ? self : all[previous]
    }
}
