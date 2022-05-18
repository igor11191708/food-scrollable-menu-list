//
//  ScrollableMenuListExample.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import SwiftUI
import d3_menu_bar

enum MenuItems: String, IMenuItem {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case treats = "Treats"
    case dessert = "Dessert"
    case drink = "Drink"
    case sushi = "Sushi"
    case pizza = "Pizza"
}


public struct ScrollableMenuListExample: View {

    let data: [ListModel]
    
    @State private var toggleScheme = false

    public init() {
        var d: [ListModel] = []
        for _ in 1...50 {
            let i = Int.random(in: 0...6)
            let category = MenuItems.allCases[i]
            let description = "Pizza, dish of Italian origin consisting of a flattened disk of bread dough topped with some combination of olive oil, oregano, tomato, olives, mozzarella or other cheese, and many other ingredients, baked quickly"
            let price = Int.random(in: 14...45)
            let title = [
                "Lasagna",
                "Chicken a la king",
                "Premium beef stew",
                "Beef caserole",
                "Roast chicken breast",
                "Taco mince mix",
                "Roast beef slices",
                "Three bean stew",
                "Veg spring rolls"
            ].randomElement()!
            
            d.append(
                    .init(category: category,
                    title: title,
                    description: description,
                    price: "\(price)")
            )
        }
        data = d
    }

    public var body: some View {
        VStack(spacing : 0) {
            ScrollableMenuList(items: data, content: { ItemTpl(item: $0) })
            DayNightToggle(toggleScheme: $toggleScheme)
        }
        .background(toggleScheme ? .black : .white)
        .environment(\.colorScheme, toggleScheme ? .dark : .light)
    }



}

struct ScrollableMenuListExample_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableMenuListExample()
    }
}
