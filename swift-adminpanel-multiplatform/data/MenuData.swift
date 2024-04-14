//
//  MenuData.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 17/03/24.
//

import Foundation

class MenuData{
   
        let options : [MenuItem] = [
            MenuItem(name: "Productos", image: "doc.fill",option: EnumOptionsSidebar.PRODUCTS),
            MenuItem(name: "Categorias", image: "doc.fill",option: EnumOptionsSidebar.CATEGORIES),
            MenuItem(name: "Banners", image: "doc.fill",option: EnumOptionsSidebar.BANNERS ),
            MenuItem(name: "Clientes", image: "doc.fill",option: EnumOptionsSidebar.CUSTOMERS),
            MenuItem(name: "Motorizados", image: "doc.fill",option: EnumOptionsSidebar.MOTORIZED),
        ]
         
}
