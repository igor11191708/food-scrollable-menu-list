//
//  ItemTpl.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI


/// Item template
struct ItemTpl: IItemTpl {

    @Environment(\.colorScheme) var colorScheme

    // MARK: - Config
    
    /// Data for template
    let item: ListModel

    // MARK: - Life circle

    /// The content and behavior of the view
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(spacing: 5) {
                    Text(item.title)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(item.price)$")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        } .padding(.horizontal)
            .foregroundColor(getColor)
        Divider().background(getColor).padding(.horizontal)
    }

    // MARK: - Private
    private var getColor: Color {
        colorScheme == .dark ? .white : .black
    }

}
