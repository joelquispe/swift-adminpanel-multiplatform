//
//  ContentView.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 17/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    var body: some View{
        SidebarView()
    }
   
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
