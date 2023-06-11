//
//  Model.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/11/23.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Person {
    var name: String
    var isSaved: Bool
    
    init(name: String, isSaved: Bool) {
        self.name = name
        self.isSaved = isSaved
    }
}
