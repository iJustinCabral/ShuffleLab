//
//  ShuffleLabApp.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import SwiftUI
import SwiftData

@main
struct ShuffleLabApp: App {

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [Person.self, Group.self])
    }
}
