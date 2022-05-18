//
//  IListModel.swift
//
//
//  Created by Igor Shelopaev on 18.05.2022.
//

import Foundation
import d3_menu_bar

/// Base model interface
public protocol IListModel : Identifiable {

    associatedtype Category = IMenuItem
    
    /// Identifier
    var id : UUID { get }
    
    /// Menu categories
    var category: Category { get }
}
