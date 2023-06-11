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
        
    var body: some View {
        TabView {
                ModeView()
                    .tabItem { Label("Shuffle Lab", systemImage: "filemenu.and.selection") }
            
                SavedNamesView()
                    .tabItem { Label("Saved Names", systemImage: "list.star") }
            
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape")}
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Person.self, inMemory: true)
}
