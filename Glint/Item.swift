//
//  Item.swift
//  Glint
//
//  Created by GHADAH ALENEZI on 06/11/1446 AH.
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
