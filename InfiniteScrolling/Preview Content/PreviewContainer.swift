//
//  PreviewContainer.swift
//  InfiniteScrolling
//
//  Created by Thach Nguyen Trong on 3/21/24.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        for index in 1..<501 {
            let item = Item(itemId: index, name: "Item \(index)")
            container.mainContext.insert(item)
        }
        return container
    } catch {
        fatalError("Failed to initialize the model container.")
    }
    
}()
