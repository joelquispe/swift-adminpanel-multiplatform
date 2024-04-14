//
//  CategoriesView.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 19/03/24.
//

import SwiftUI
import PhotosUI

struct CategoriesView: View {
    @StateObject private var categoriesVM = CategoriesViewModel()
    
    @State var tfName = ""
    @State var tfImage = ""
    @State var isShowForm = false
    @State var isShowImportes = false
    @State var isShowPermissionsAlert = false
    var body: some View {
        VStack{
            Table(self.categoriesVM.categories, columns: {
                TableColumn("Id",value: \.idString)
                TableColumn("Nombre", value: \.name)
                TableColumn("Imagen",value: \.image)
                
            })
                .navigationTitle("Categorias")
                .toolbar(content: {
                    ToolbarItem {
                        Text("Crear")
                            .onTapGesture {
                                isShowForm = true
                            }
                    }
                })
                .sheet(isPresented: $isShowForm, content: {
                    FormCategoriesView(isShowForm: $isShowForm)
                })
                .onAppear() {
                    Task{
                        do{
                            try await self.categoriesVM.getAll()
                        }catch{
                            print(error)
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    CategoriesView()
}
