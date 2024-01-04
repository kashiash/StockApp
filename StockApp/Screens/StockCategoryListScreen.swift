//
//  StockCategoryListScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 04/01/2024.
//

import SwiftUI

struct StockCategoryListScreen: View {

    @EnvironmentObject private var model: StockModel
    var body: some View {
        NavigationStack{
            List {
                ForEach (model.stockCategories) { category in
                    HStack{
                        Circle()
                            .fill(Color.fromHex(category.colorCode))
                            .frame(width:25,height: 25)
                        Text(category.title)
                        //.foregroundColor(Color.fromHex(category.colorCode))
                    }
                }
                .onDelete(perform: deleteStockCategory)
            }
            .task {
                await fetchStockCategories()
            }

        }
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
    }

    func fetchStockCategories () async {
        do {
            try await model.getStockCategories()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteStockCategory(at offsets: IndexSet) {
        offsets.forEach( { index in
            let category = model.stockCategories[index]
            Task {
                do {
                    try await model.deleteStockcategory(stockCategoryId: category.id)
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
    }
}

#Preview {
    StockCategoryListScreen()
        .environmentObject(StockModel())
}
