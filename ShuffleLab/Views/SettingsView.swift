//
//  SettingsView.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
         NavigationView {
             Form {
                 Section {
                     LabeledContent("Shuffle Lab Version", value: "0.1.0")
                 } header: {
                     Text("App Version")
                 }
             }
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
