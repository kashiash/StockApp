//
//  StockItemListView.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 06/01/2024.
//

import SwiftUI
import StockSharedDTOs

struct StockItemListView: View {

    let stockItems: [StockItemResponseDTO]
    let onDelete: (UUID) -> Void

    var body: some View {

            List{
                ForEach(stockItems) { item in
                    Text(item.title)
                }
                .onDelete(perform: deleteStockItem)
            }
    }

    func deleteStockItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let stockItem = stockItems[index]
            onDelete(stockItem.id)
        }
    }
}

#Preview {
    StockItemListView(stockItems: [], onDelete: {_ in })
}
