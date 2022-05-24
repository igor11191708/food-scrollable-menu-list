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
                    let rect = proxy.frame(in: .named("OFFSET"))
                    Color.clear.preference(key: OffsetCategoryKey.self, value: rect)
                }
        }
            .onPreferenceChange(OffsetCategoryKey.self, perform: onOffsetCategoryChanged)
    }

    // MARK: - Private


    /// Sync list and up menu according to active area
    /// - Parameter rect: Active area reletive to namespace OFFSET
    private func onOffsetCategoryChanged(rect: CGRect) {

        let minY = rect.minY
        let height = size.height

        if suspend { return }

        ///if not selected and in the rect
        let condition = minY >= 0 && minY < height && selected != category

        if condition {
            select(category)
        } else {

            ///if selected but beyond of the rect to  set active previous category
            let nextCondition = minY > height && selected == category

            if nextCondition {
                select(category.previous())
            }
        }
    }

    /// Select category
    /// - Parameter category: Type of category
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
        guard let idx = all.firstIndex(of: self) else {
            return self
        }
        let previous = all.index(idx, offsetBy: -1)
        return previous < startIndex ? self : all[previous]
    }
}
