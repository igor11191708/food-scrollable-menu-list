//
//  ScrollableMenuList.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI
import d3_menu_bar
import Combine

@available(iOS 15.0, macOS 12.0, watchOS 6.0, *)
/// # Auto scrollable header menu (SwiftUI)
public struct ScrollableMenuList<C: IMenuItem, M : IListModel, Content: View>: View where M.Category == C
{
    ///detecting scroll movement
    private let detector: CurrentValueSubject<CGFloat, Never>

    ///publisher scroll movement
    private let publisher: AnyPublisher<CGFloat, Never>

    ///Grouped items
    private let items: [C: [M]]

    /// Menu categories
    private let category: [C]

    ///Selected menu
    @State private var selected: C?

    /// Suspend scroll from ```OffsetCategory```
    /// modifire
    @State private var suspend: Bool = false

    // MARK: - Cgf

    /// Template for menu items
    let content: (M) -> Content

    /// Size strategy
    /// Default strategy for the menu item width ```auto```
    let menuBarStrategy: MenuBar<C>.Strategy

    /// menu color
    let menuBarColor: Color

    /// menu style
    let menuBarStyle: MenuBar<C>.Style

    // MARK: - Life circle

    /// - Parameters:
    ///   - items: set of data
    ///   - menuStrategy: Size strategy
    ///   - menuColor: menu color
    ///   - menuStyle: menu style
    public init(
        items: [M],
        content: @escaping (M) -> Content,
        menuStrategy: MenuBar<C>.Strategy = .auto,
        menuColor: Color? = .blue,
        menuStyle: MenuBar<C>.Style = .square
    ) {

        self.items = Dictionary(grouping: items, by: { $0.category })

        self.content = content

        self.category = C.allCases.map { $0 }

        _selected = State(initialValue: category.first)

        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
        self.detector = detector

        self.menuBarStrategy = menuStrategy
        self.menuBarColor = menuColor ?? .black
        self.menuBarStyle = menuStyle
    }

    /// The content and behavior of the view
    public var body: some View {
        VStack(spacing: 5) {
            headerTpl
            ScrollViewReader { proxy in
                GeometryReader { p in
                    ScrollView {
                        bodyTpl(p)
                    }
                        .coordinateSpace(name: "OFFSET")
                        .onChange(of: suspend) { _ in scrollTo(category: selected, proxy) }
                        .onReceive(publisher) { _ in suspend = false }
                }
            }
        }.padding(.top)
    }
    
    // MARK: - Private

    
    /// Offset category modifier
    /// - Parameters:
    ///   - category: category
    ///   - proxy: geometry proxy
    /// - Returns: modifier
    private func offsetCategoryModifier(_ category: C, _ proxy: GeometryProxy) -> OffsetCategory<C> {
            .init(category: category, selected: $selected, suspend: $suspend, size: proxy.size)
    }

    @ViewBuilder
    /// Template for main body
    /// - Parameter proxy: geometry proxy
    /// - Returns: view
    private func bodyTpl(_ proxy: GeometryProxy) -> some View {
        VStack {
            ForEach(category, id: \.self) {

                if let items = items[$0] {
                    CategoryTpl(
                        content: content,
                        items: items,
                        category: $0,
                        color: menuBarColor)
                        .id($0.id)
                        .modifier(offsetCategoryModifier($0, proxy))
                }
            }
        }
            .modifier(ScrollDetect())
            .onPreferenceChange(ViewOffsetKey.self) { detector.send($0) }
            .padding(.bottom, 250)
    }

    @ViewBuilder
    /// Header template
    private var headerTpl: some View {
        MenuBar(
            values: category,
            selected: $selected,
            strategy: menuBarStrategy,
            color: menuBarColor,
            style: menuBarStyle
        )
            .onSelectionChanged { _ in suspend = true }
            .padding(.leading, 5)
        Divider().padding(.horizontal, -15).background(menuBarColor)
    }


    /// Scroll to a category
    /// - Parameters:
    ///   - category: category to scroll to
    ///   - proxy: scroll proxy
    private func scrollTo(category: C?, _ proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo(category?.id, anchor: .topTrailing)
        }
    }
}

struct ScrollableMenuList_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableMenuListExample()
    }
}
