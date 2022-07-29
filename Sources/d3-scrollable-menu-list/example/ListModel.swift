//
//  ListModel.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import Foundation

/// Model for example
struct ListModel: IListModel {
    let id = UUID()

    let category: MenuItems

    let title: String

    let description: String

    let price: String
}
