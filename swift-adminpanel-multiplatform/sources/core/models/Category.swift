//
//  Category.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 19/03/24.
//

import Foundation

struct Category: Identifiable, Codable{
    let id: Int
    let name: String
    var urlImage : String?
    var image: String
    
    var idString: String {
        return String(id)
    }
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case image = "image"
    }
    
}
