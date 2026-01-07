//
//  Item.swift
//  MediRead
//
//  Created by 이현탁 on 1/7/26.
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
