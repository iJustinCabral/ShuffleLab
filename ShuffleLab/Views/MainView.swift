//
//  ModeView.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import SwiftUI
import SwiftData

enum ShuffleMode: String, CaseIterable {
    case names = "Random Order"
    case winner = "Pick-a-Winner"
    case swap = "Yankee Swap"
    case teams = "Random Teams"
}

enum InsertOption: String, CaseIterable {
    case new = "New"
    case saved = "Groups"
}

struct MainView: View {
    
    @Query(filter: #Predicate<Person> { $0.isSaved == false }) var people: [Person]
    @Query var group: [Group]
    @Environment(\.modelContext) private var modelContext
    
    @State var modeSelection: ShuffleMode = .names
    @State var insertSelection: InsertOption = .new
    @State var nameInput = ""
    @State var stepValue = 2
    @State var showLabView = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Choose mode:", selection: $modeSelection) {
                        ForEach(ShuffleMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue)
                        }
                    }
                    
                    if modeSelection == .teams {
                        Stepper("Team Count: \(stepValue)", value: $stepValue, in: 2...8)
                    }
                } header: {
                    Text("Mode")
                }
                
                Section {
                    NavigationLink(destination: FavoritesView()) {
                        Text("Select People or Group")
                    }
                } header: {
                    Text("Favorites")
                }
                
                Section {
                    TextField(text: $nameInput) {
                        Text("Enter a person's name")
                    }
                    
                    Button(action: {
                        let newPerson = Person(name: nameInput, isSaved: false)
                        modelContext.insert(newPerson)
                        nameInput = ""
                    }) {
                        Text("Add Person")
                    }
                } header: {
                    Text("Add new people")
                }
                
                Section {
                    if (people.isEmpty) {
                        ContentUnavailableView("No heads to count", systemImage: "person.fill")
                    }
                    else {
                        List {
                            ForEach(people, id:\.self) { person in
                                Text("\(person.name)")
                            }
                            .onDelete(perform: deleteItems)
                        }
                        
                    }
                } header: {
                    Text("Head Count: \(people.count)")
                }

            }
            .navigationTitle("Shuffle Lab")
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()){Image(systemName: "gear")})
            .overlay(
                ShuffleButton(),
                alignment: .bottomTrailing
            )
            .sheet(isPresented: $showLabView) {
                LabView()
                    .presentationDetents([.medium])
            }
        }
        .accentColor(.purple)
    }
    
    private func addPerson() {
        withAnimation {
            let newPerson = Person(name: nameInput, isSaved: false)
            modelContext.insert(newPerson)
        }
    }

   private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(people[index])
            }
        }
    }

    @ViewBuilder
    func ShuffleButton() -> some View {
        Button(action: { showLabView.toggle() }) {
        Capsule().fill(Color.purple)
            .frame(width: 60, height: 60)
            .shadow(radius: 4)
            .overlay(Image(systemName: "arrow.up.left.bottomright.rectangle.fill").foregroundColor(.white).font(.title).fontWeight(.semibold))
        }.padding(.horizontal)
    }
}

#Preview {
    MainView()
        .modelContainer(for: [Person.self, Group.self], inMemory: true)
}
