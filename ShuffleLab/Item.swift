//
//  Item.swift
//  ShuffleLab
//
//  Created by Justin Cabral on 6/10/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
