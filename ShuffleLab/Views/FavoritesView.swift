//
//  SavedNamesView.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import SwiftUI
import SwiftData

enum FavOption: String, CaseIterable {
    case names = "People"
    case templates = "Groups"
}

struct FavoritesView: View {
    
    @Query(filter: #Predicate<Person> { $0.isSaved == true }) var people: [Person]
    @Query var group: [Group]
    @Environment(\.modelContext) private var modelContext
    
    @State var favSelection: FavOption = .names
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Picker("", selection: $favSelection) {
                        ForEach(FavOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                }
                
                
                if favSelection == .names {
                    List {
                        ForEach(people, id:\.self) { person in
                            Text("\(person.name)")
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                else {
                    List {
                        ForEach(group, id:\.self) { template in
                            Text("\(template.name)")
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarItems(trailing: EditButton())
            .navigationBarItems(leading: Button(action: addPerson) {Image(systemName: "plus")})
            .accentColor(.purple)
        }
        .accentColor(.purple)
    }
    
    private func addPerson() {
        withAnimation {
            if favSelection == .names {
                let newPerson = Person(name: "\(Date())", isSaved: true)
                modelContext.insert(newPerson)
            }
            else {
                let newTemplate = Group(name: "Testing", people: people)
                modelContext.insert(newTemplate)
            }
        }
    }

   private func deleteItems(offsets: IndexSet) {
        withAnimation {
            if favSelection == .names {
                for index in offsets {
                    modelContext.delete(people[index])
                }
            }
            else {
                for index in offsets {
                    modelContext.delete(group[index])
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: [Person.self, Group.self], inMemory: true)

}
