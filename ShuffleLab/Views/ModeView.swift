//
//  ModeView.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import SwiftUI

enum ShuffleMode: String, CaseIterable {
    case names = "Random Order"
    case winner = "Pick-a-Winner"
    case swap = "Yankee Swap"
    case teams = "Random Teams"
}

enum InsertOption: String, CaseIterable {
    case new = "New"
    case saved = "Templates"
}

struct ModeView: View {
    
    @State var modeSelection: ShuffleMode = .names
    @State var insertSelection: InsertOption = .new
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Shuffle Lab")
            .accentColor(.purple)
        }
    }
}

#Preview {
    ModeView()
}
