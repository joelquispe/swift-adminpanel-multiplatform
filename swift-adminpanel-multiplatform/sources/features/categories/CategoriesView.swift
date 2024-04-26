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
    private var supabaseService = SupabaseService()
    @State var tfName = ""
    @State var tfImage = ""
    @State var isShowForm = false
    @State var isShowImportes = false
    @State var isShowPermissionsAlert = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    #if os(iOS)
    var isCompact : Bool {
        horizontalSizeClass == .compact
    }
    #else
    var isCompact = false
    #endif
  
    var body: some View {
        VStack{
            if(isCompact){
                List{
                    ForEach(self.categoriesVM.categories,id: \.idString){
                        item in
                        HStack{
                        Image(systemName: "truck.box.fill")
                            Spacer().frame(width: 15)
                            Text(item.name)
                                .foregroundStyle(.black)
                                .padding()
                        }
                    }
                    .onDelete(perform: {
                        indexSet in
                        Task{
                            do{
                                try await self.categoriesVM.delete(indexSet)
                            }catch{
                                print("error")
                            }
                        }
                    })
                }
            }else{
                Table(self.categoriesVM.categories, columns: {
                    TableColumn("Id",value: \.idString)
                    TableColumn("Nombre", value: \.name)
                    TableColumn("Imagen"){
                        category in
                        AsyncImage(url: URL(string: category.urlImage ?? "")
                                   ,content: {image in image
                                .resizable()
                            .frame(width:70,height: 70)}
                                   ,placeholder: {
                            ProgressView()
                        })
                    }
                    TableColumn("Acciones"){ category in
                        HStack{
                            Image(systemName: "pencil.line")   
                            Spacer().frame(width: 20)
//                            Image(systemName: "trash.fill")
//                                .onTapGesture {
//                                    Task{
//                                        do{
//                                            try await categoriesVM.delete(category.id)
//                                            
//                                        }catch{
//                                            print(error)
//                                            print("error al eliminar")
//                                        }
//                                    }
//                                }
                        }
                    }
                })
                    
                    
            }
        }
        .navigationTitle("Categorías")
        .toolbar{
            ToolbarItem {
                Text("Crear")
                    .onTapGesture {
                        isShowForm = true
                    }
            }
        }
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
        .environmentObject(self.categoriesVM)
    }
}

#Preview {
    CategoriesView()
}
