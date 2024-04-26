//
//  CategoriesViewModel.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 25/03/24.
//

import Foundation
import Supabase
class CategoriesViewModel : ObservableObject{
    @Published var categories: [Category] = []
    
    let supabaseService = SupabaseService()
    
    //obteniendo todo los datos desde supabase
    @MainActor
    func getAll() async throws {
        let response = try await SupabaseConfig.client.database.from("categories").select().execute()
        let data = try JSONDecoder().decode([Category].self, from: response.data)
        self.categories = data.sorted{ $0.id > $1.id}
        for index in self.categories.indices{
            let signedUrl = try await supabaseService.generateSignedUrl(path: "categories",fileName: data[index].image)
            
            self.categories[index].urlImage = signedUrl
        }
    }
    
    func upload(fileName:String,fileData: Data)async throws{
        try await SupabaseConfig.client.storage
          .from(ProcessInfo.processInfo.environment["SUPABASE_BUCKET"]!)
          .upload(
            path: "public/categories/\(fileName)",
            file: fileData,
            options: FileOptions(
              cacheControl: "3600",
              contentType: "image/png",
              upsert: false
            )
          )
    }
    
    func create(category: Category) async throws{
        var id = 1
        print(self.categories)
        if(self.categories.count > 0){
            id = self.categories.last!.id + 1
        }
        let newCategory = Category(id: id, name: category.name, image: category.image)
        print(newCategory.id)
        try await SupabaseConfig.client.database.from("categories").insert(newCategory).execute()
        try await getAll()
    }
    
    func update(category:Category) throws{
        
    }
    
    func delete(_ indexSet:IndexSet) async throws{
        let findCategory = self.categories[indexSet.first!]
        
        try await SupabaseConfig.client.database.from("categories").delete().eq("id", value: findCategory.id).execute()
        try await self.supabaseService.deleteFile(path: "categories", fileName: findCategory.image)
        try await self.getAll()
    }
    
}
