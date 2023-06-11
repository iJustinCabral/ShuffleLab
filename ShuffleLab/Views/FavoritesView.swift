//
//  SavedNamesView.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    
    @Query var savedPeople: [Person]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            List{
                ForEach(savedPeople, id:\.self) { person in
                    Text("\(person.name)")
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Favorites")
            .navigationBarItems(trailing: EditButton())
            .navigationBarItems(leading: Button(action: addPerson) {Image(systemName: "plus")})
            .accentColor(.purple)
        }
    }
    
    private func addPerson() {
        withAnimation {
            let newPerson = Person(name: "\(Date())", isSaved: true)
            modelContext.insert(newPerson)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(savedPeople[index])
            }
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: Person.self, inMemory: true)

}
