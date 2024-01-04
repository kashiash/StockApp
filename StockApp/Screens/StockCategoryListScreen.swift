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
                ForEach   (model.stockCategories) { category in
                    HStack{
                        Circle()
                            .fill(Color.fromHex(category.colorCode))
                            .frame(width:25,height: 20)
                        Text(category.title)
                        //.foregroundColor(Color.fromHex(category.colorCode))
                    }
                }
            }
            .task {
                await fetchStockCategories()
            }

        }
        .navigationTitle("Categories")
    }

    func fetchStockCategories () async {
        do {
            try await model.getStockCategories()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    StockCategoryListScreen()
        .environmentObject(StockModel())
}
