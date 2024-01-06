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
    
    var body: some View {

            List{
                ForEach(stockItems) { item in
                    Text(item.title)
                }
            }
        
    }
}

#Preview {
    StockItemListView(stockItems: [])
}
