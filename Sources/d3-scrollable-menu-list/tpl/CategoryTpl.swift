//
//  CategoryTpl.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import d3_menu_bar
import SwiftUI

/// Category template
struct CategoryTpl<C: IMenuItem, M: IListModel, Content: IItemTpl>: View where M.Category == C {
    @Environment(\.colorScheme) var colorScheme

    // MARK: - Config

    /// Template for menu items
    let content: (M) -> Content

    /// Set of data
    let items: [M]

    /// Menu category
    let category: C

    /// Get color from menu
    let color: Color

    // MARK: - Life circle

    /// The content and behavior of the view
    var body: some View {
        VStack {
            Text(category.rawValue)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 5)
                .foregroundColor(getColor)

            ForEach(items, id: \.id) {
                content($0)
            }
        }
    }

    // MARK: - Private

    private var getColor: Color {
        colorScheme == .dark ? color.doBrighter(k: 0.2) : color
    }
}
