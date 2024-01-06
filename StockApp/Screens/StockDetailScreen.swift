//
//  StockDetailScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 06/01/2024.
//

import SwiftUI
import StockSharedDTOs

struct StockDetailScreen: View {
    
    @EnvironmentObject private var model: StockModel
    let stockCategory: StockCategoryResponseDTO
    
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack {
            if model.stockItems.isEmpty {
                Text("No items found for \(stockCategory.title ) \(stockCategory.id)")
            } else {
                VStack{
                    StockItemListView(stockItems: model.stockItems)
                }
            }
        }
        .navigationTitle(stockCategory.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add stock item",systemImage: "plus") {
                    isSheetPresented.toggle()
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            NavigationStack{
                AddStockItemScreen()
            }
        }
        .onAppear{
            model.stockCategory = stockCategory
        }
        .task {
            await populateStockItems()
        }
    }
    
    func populateStockItems() async {
        do {
            try await model.populateStockItemsBy(stockcategoryId: stockCategory.id)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack {
        StockDetailScreen(stockCategory: StockCategoryResponseDTO(id: UUID(uuidString: "a1b13ea4-3ba9-4f15-ab40-158cdffbf0e9")!, title: "Napoje", colorCode: "#00FF00"))
            .environmentObject(StockModel())
    }
}
