//
//  MenuItem.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 17/03/24.
//

import Foundation

struct MenuItem:Identifiable,Hashable{
    let id =  UUID()
    var name :String
    var image :String
    var option: EnumOptionsSidebar
}
