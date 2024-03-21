//
//  ContentView.swift
//  InfiniteScrolling
//
//  Created by Thach Nguyen Trong on 3/21/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var items: [Item] = []
    @State private var currentPage: Int = 0
    
    var body: some View {
        NavigationStack {
            List(items) { item in
                LabeledContent(item.name) {
                    Text("\(item.itemId)")
                        .onAppear {
                            fetchItemsIfNeeded(item: item)
                        }
                }
                
            }.onAppear(perform: {
                performFetch()
            })
            .navigationTitle("Infinite Scrolling")
        }
    }
    private func fetchItemsIfNeeded(item: Item) {
        /// Kiểm tra item cuối cùng đang xuất hiện trên màn hình
        /// có phải là item cuối cùng đã được load hay không ?
        /// Nếu đúng thì load tiếp để nạp dữ liệu
        if let lastItem = items.last, lastItem == item {
            currentPage += 1
            /// Load more items.
            performFetch(currentPage: currentPage)
            
        }
    }
    
    private func performFetch(currentPage: Int = 0) {
        var fetchDescriptor = FetchDescriptor<Item>()
        fetchDescriptor.fetchLimit  = 20
        fetchDescriptor.fetchOffset = 20 * currentPage
        fetchDescriptor.sortBy      = [.init(\Item.itemId, order: .forward)]
        
        do {
            self.items += try modelContext.fetch(fetchDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

#Preview { @MainActor in
    ContentView()
        .modelContainer(previewContainer)
}
