//
//  CategoriesViewModel.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 25/03/24.
//

import Foundation

class CategoriesViewModel : ObservableObject{
    
    
    @Published var categories: [Category] = []
    
    //obteniendo todo los datos desde supabase
    func getAll() async throws {
        let response = try await SupabaseConfig.client.database.from("categories").select().execute()
        let data = try JSONDecoder().decode([Category].self, from: response.data)
        print(data)
        DispatchQueue.main.async {
            self.categories = data
            print(self.categories)
        }
    }
    
    func create(category: Category) async throws{
        var id = 1
        if(!self.categories.isEmpty){
            id = self.categories.first!.id + 1
        }
        let newCategory = Category(id: id, name: category.name, image: category.image)
        try await SupabaseConfig.client.database.from("categories").insert(newCategory).execute()
        try await getAll()
    }
    
    func update(category:Category) throws{
        let index = categoriesData.firstIndex { item in
            item.id == category.id
        }
        if let index = index {
            categoriesData[index] = category
        }else{
           print("error al editar")
        }
    }
    
    func delete(_ id:Int){
        let newCategories = categoriesData.filter { item in
            item.id != id
        }
        categoriesData = newCategories
        
    }
    
}
