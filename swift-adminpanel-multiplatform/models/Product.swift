//
//  Product.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 17/03/24.
//

import Foundation

struct Product: Identifiable{
    
    let id: String
    let name : String
    let description: String
    let price: String
    let category: Category
}
