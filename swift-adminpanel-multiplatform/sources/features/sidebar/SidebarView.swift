//
//  SidebarView.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 19/03/24.
//

import SwiftUI

struct SidebarView: View {
    @State var idStoreItem : MenuItem.ID?
    @State var optionSelect : EnumOptionsSidebar?
    var menuData = MenuData()
    
    
    var body: some View {
        NavigationSplitView {
            List(menuData.options,selection: $optionSelect ){ item in
                HStack{
                    Image(systemName: item.image)
                    Text(item.name)
                }.tag(item.option)
            }
            .navigationTitle("My store")
        } detail: {
            if let value = optionSelect{
                switch(value){
                    case .BANNERS :
                    BannersView()
                case .CATEGORIES:
                    CategoriesView()
                case .CUSTOMERS:
                    CustomersView()
                case .MOTORIZED:
                    MotorizedView()
                case .PRODUCTS:
                    ProductsView()
                case .ORDERS:
                    OrdersView()
                }
            }else{
                Text("Seleccione una opción")
            }
            
        }

    }
}

#Preview {
    SidebarView()
}
