//
//  FormCategoriesView.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 26/03/24.
//

import SwiftUI
import PhotosUI
struct FormCategoriesView: View {
    @StateObject private var categoriesVM = CategoriesViewModel()
    @State var photosPicker : PhotosPickerItem?
    @State var image: Image?
    @State private var tfName = ""
    @State private var tfImage = ""
    @Binding var isShowForm: Bool
    var body: some View {
            VStack(alignment: .leading){
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
                            
                            if self.image != nil{
                                self.image!
                                    .resizable()
                                    .frame(width: 100,height:100)
                            }else{
                                Text("")
                            }
                            TextField(text: $tfImage) {
                                Text("Imagen")
                            }
                            .textFieldStyle(.roundedBorder)
                        }
                        
                        Group {
                            Button(action: {
                                let newCategory = Category(id: 1, name: tfName, image: tfImage)
                                Task{
                                    do{
                                        try await self.categoriesVM.create(category: newCategory)
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
                    if let loaded = try? await photosPicker?.loadTransferable(type: Image.self){
                        self.image = loaded
                                //self.uploadFile()
                    }else{
                       print("error al convertir en imagen")
                    }
                }
                
            }
    }
}


