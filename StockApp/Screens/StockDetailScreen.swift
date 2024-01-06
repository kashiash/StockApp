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
        VStack{
            List(1...20,id: \.self) { index in
                Text("Stock Item \(index)")
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

        }
        .onAppear{
            model.stockCategory = stockCategory
        }
    }
}

#Preview {
    NavigationStack {
        StockDetailScreen(stockCategory: StockCategoryResponseDTO(id: UUID(), title: "Napoje", colorCode: "#00FF00"))
            .environmentObject(StockModel())
    }
}
