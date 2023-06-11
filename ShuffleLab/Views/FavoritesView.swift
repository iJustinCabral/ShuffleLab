//
//  SavedNamesView.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import SwiftUI
import SwiftData

enum FavOption: String, CaseIterable {
    case names = "Names"
    case templates = "Templates"
}

struct FavoritesView: View {
    
    @Query var savedPeople: [Person]
    @Query var savedTemplates: [Template]
    @Environment(\.modelContext) private var modelContext
    
    @State var favSelection: FavOption = .names
    
    var body: some View {
        NavigationView {
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
                        ForEach(savedPeople, id:\.self) { person in
                            Text("\(person.name)")
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                else {
                    List {
                        ForEach(savedTemplates, id:\.self) { template in
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
    }
    
    private func addPerson() {
        withAnimation {
            if favSelection == .names {
                let newPerson = Person(name: "\(Date())", isSaved: true)
                modelContext.insert(newPerson)
            }
            else {
                let newTemplate = Template(name: "Testing", people: savedPeople)
                modelContext.insert(newTemplate)
            }
        }
    }

   private func deleteItems(offsets: IndexSet) {
        withAnimation {
            if favSelection == .names {
                for index in offsets {
                    modelContext.delete(savedPeople[index])
                }
            }
            else {
                for index in offsets {
                    modelContext.delete(savedTemplates[index])
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: [Person.self, Template.self], inMemory: true)

}
