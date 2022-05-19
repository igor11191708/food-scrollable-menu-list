//
//  IItemTpl.swift
//  
//
//  Created by Igor Shelopaev on 19.05.2022.
//

import SwiftUI

/// Interface for item view
public protocol IItemTpl: View{
    
    associatedtype Model : IListModel
    
    /// Data for template
    var item: Model { get }
}
