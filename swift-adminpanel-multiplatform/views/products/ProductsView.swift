//
//  ProductsView.swift
//  macos-admin-panel
//
//  Created by joel on 16/03/24.
//

import SwiftUI
import PhotosUI

struct ProductsView: View {
    @State var products: [Product] = [Product(id: "1", name: "Licuadora", description: "Marca oster en oferta", price: "100.00",category: Category(id: 1, name: "Electrodomesticos", image: ""))]
    @State var tfName = ""
    @State var tfDescription = ""
    @State var tfImage = ""
    @State var tfPrice = ""
    @State var tfCategory = ""
    @State var productImage : PhotosPickerItem?
    
    var categories = ["Sandwich","Bebidas","Comidas","Golosinas","Extras"]
    
    var body: some View {
        Form{
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())],spacing: 15){
                TextField(text: $tfName, label: {
                    Text("Nombre")
                        .frame(width: 75,alignment: .leading)
                        
                })
                TextField(text: $tfPrice, label: {
                    Text("Precio")
                        .frame(width: 75,alignment: .leading)
                })
                
                Picker(selection: $tfCategory, content: {
                    ForEach(categories,id: \.self){item in
                        Text(item)}
                }) {
                    Text("Seleccione una categoria")
                }
                .pickerStyle(.menu)
                HStack(){
                    Text("Seleccione una imagen")
                    Spacer()
                    PhotosPicker(selection: $productImage,matching: .images,photoLibrary: .shared()) {
                        Text("Imagen")
                    }
                }
                
                
                
                TextField(text: $tfDescription, axis: .vertical, label: {
                    Text("Descripción")
                        .frame(width: 75,alignment: .leading)
                })
                .lineLimit(5)
               
                
                
            }
            .padding()
        }
       
        Table(products) {
            TableColumn("Id",value: \.id)
            TableColumn("Nombre",value: \.name)
            TableColumn("Precio",value: \.price)
        }
        
        .navigationTitle("Mis productos")

    }
}

#Preview {
    ProductsView()
}
