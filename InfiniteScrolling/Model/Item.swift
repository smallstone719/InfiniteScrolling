//
//  Item.swift
//  InfiniteScrolling
//
//  Created by Thach Nguyen Trong on 3/21/24.
//

import Foundation
import SwiftData

@Model
class Item {
    let itemId: Int
    let name: String
    
    init(itemId: Int, name: String) {
        self.itemId = itemId
        self.name = name
    }
}
