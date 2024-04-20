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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    #if os(iOS)
    var isCompact : Bool {
        horizontalSizeClass == .compact
    }
    #else
    var isCompact = false
    #endif
  
    var supabaseService = SupabaseService()
    var body: some View {
        VStack{
            Button {
                    Task{
                        do{
                            let result = try await supabaseService.createBucket();
                        }catch{
                            print(error)
                        }
                    }
            } label: {
                Text("Create bucket")
            }
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
                }
            }else{
                Table(self.categoriesVM.categories, columns: {
                    TableColumn("Id",value: \.idString)
                    TableColumn("Nombre", value: \.name)
                    TableColumn("Imagen",value: \.image)
                    
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
