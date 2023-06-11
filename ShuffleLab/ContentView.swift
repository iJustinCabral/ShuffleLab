//
//  ContentView.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
        
    var body: some View {
        TabView {
                ModeView()
                    .tabItem { Label("Modes", systemImage: "filemenu.and.selection") }
            
                SavedNamesView()
                    .tabItem { Label("Saved Names", systemImage: "list.star") }
            
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape")}
        }
        .accentColor(.purple)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
