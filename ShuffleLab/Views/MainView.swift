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
    
    @Query var people: [Person]
    @Query var group: [Group]
    @Environment(\.modelContext) private var modelContext
    
    @State var modeSelection: ShuffleMode = .names
    @State var insertSelection: InsertOption = .new
    @State var nameInput = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Choose mode:", selection: $modeSelection) {
                        ForEach(ShuffleMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue)
                        }
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
                    Button(action: {}) {
                        Text("Add Person")
                    }
                } header: {
                    Text("Add new people")
                }
                
                Section {
                    if (people.count.words.isEmpty) {
                        ContentUnavailableView("No people to count...", systemImage: "person.fill")
                    }
                    else {
                        List(people) { person in
                            Text("\(person.name)")
                        }
                    }
                } header: {
                    Text("Head Count: \(people.count)")
                }

            }
            .navigationTitle("Shuffle Lab")
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()){Image(systemName: "gear")})
            .overlay(
                Button(action: {}) {
                    Text("Enter The Lab")
                }.padding()
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color.purple))
                ,
                alignment: .bottom
            )
    
        }
        .accentColor(.purple)
    }
}

#Preview {
    MainView()
        .modelContainer(for: [Person.self, Group.self], inMemory: true)
}

/**
 
 ScrollView(.vertical) {
     HStack {
         Text("Choose Mode:")
             .font(.title3)
             .fontWeight(.semibold)
         
         Picker("", selection: $modeSelection) {
             ForEach(ShuffleMode.allCases, id: \.self) { mode in
                 Text(mode.rawValue)
             }
         }
     }
     
     HStack {
         Picker("", selection: $insertSelection) {
             ForEach(InsertOption.allCases, id: \.self) { option in
                 Text(option.rawValue)
             }
         }.pickerStyle(SegmentedPickerStyle())
             .padding(.horizontal)
     }
 }
 */
