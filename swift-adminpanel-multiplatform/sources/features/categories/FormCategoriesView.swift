//
//  FormCategoriesView.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 26/03/24.
//

import SwiftUI
import PhotosUI
struct FormCategoriesView: View {
    @EnvironmentObject() var categoriesVM: CategoriesViewModel
    
    @State var photosPicker : PhotosPickerItem?
    @State var image: Image?
    @State var categoryImage: Data?
    @State private var tfName = ""
    @State private var tfImage = ""
    @Binding var isShowForm: Bool
    var body: some View {
            VStack(alignment: .leading){
                Image(systemName: "xmark.circle")
                    .frame(width:30,height: 30)
                    .onTapGesture {
                        isShowForm = false
                    }
                Text("Crear categoría")
                    .font(.title)
                
                Form{
                    Section(content: {
                        Group {
                            TextField(text: $tfName) {
                                Text("Nombre")
                            }
                            .textFieldStyle(.roundedBorder)
                            
                            PhotosPicker(selection: $photosPicker,matching: .images,photoLibrary: .shared()) {
                                Text("Subir foto")
                            }
                            
                            if let categoryImage = self.categoryImage{
                                showImageCategory(image: categoryImage)
                            }
                        }
                        Group {
                            Button(action: {
                                Task{
                                    let currentDate = Date.now
                                    let fileName = String(currentDate.timeIntervalSince1970)
                                    let newCategory = Category(id: 1, name: tfName, image: fileName )
                                   
                                    do{
                                        try await self.categoriesVM.upload(fileName: fileName, fileData: self.categoryImage!)
                                        try await self.categoriesVM.create(category: newCategory)
                                        print("create category")
                                    }catch{
                                        print(error)
                                    }
                                }
                                
                                
                                self.isShowForm = false
                            }, label: {
                                Text("Guardar")
                                    .foregroundStyle(.black)
                            })
                        }
                    })
                    
                }
                .formStyle(.columns)
                Spacer()
            }
            .padding()
            .frame(width: 400)
            .onChange(of: photosPicker) {
                Task{
                    if let loaded = try? await photosPicker?.loadTransferable(type: Data.self){
                        self.categoryImage = loaded
                    }
                   else{
                       print("error al convertir en imagen")
                    }
                }
                
            }
    }
    
    @ViewBuilder
    func showImageCategory(image:Data) -> some View{
        #if os(iOS)
        Image(uiImage: UIImage(data: image)!)
            .resizable()
            .frame(width: 100,height: 100)
        #else
        Image(nsImage: NSImage(data: image)!)
            .resizable()
            .frame(width: 100,height: 100)
        #endif
    }
}


