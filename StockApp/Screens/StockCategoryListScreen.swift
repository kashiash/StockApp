//
//  StockCategoryListScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 04/01/2024.
//

import SwiftUI

struct StockCategoryListScreen: View {

    @EnvironmentObject private var model: StockModel


    @State var isNewCategoryViewPresented = false
    var body: some View {
        ZStack {
            if model.stockCategories.isEmpty {
                Text("No categories found")
            } else {
                
                List {
                    ForEach (model.stockCategories) { category in
                        NavigationLink(value: Route.stockCategoryDetail(category)){
                            HStack{
                                Circle()
                                    .fill(Color.fromHex(category.colorCode))
                                    .frame(width:25,height: 25)
                                Text(category.title)
                                //.foregroundColor(Color.fromHex(category.colorCode))
                            }
                        }
                    }
                    .onDelete(perform: deleteStockCategory)
                }
            }
        }
        .task {
            await fetchStockCategories()
        }
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                Button("Logout") {

                }
            }
            ToolbarItem (placement: .navigationBarTrailing){
                Button("Add",systemImage: "plus") {
                    isNewCategoryViewPresented.toggle()
                }
            }
        }
        .sheet(isPresented: $isNewCategoryViewPresented) {
            NavigationStack{
                AddStockCategoryScreen()
            }
        }
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
                    try await model.deleteStockCategory(stockCategoryId: category.id)
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
    }
}

struct StockCategoryListScreenContainer: View {
    @StateObject private var model = StockModel()
    @StateObject private var appState = AppState()

    var body : some View {
        NavigationStack(path: $appState.routes) {
            StockCategoryListScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .register:
                        RegistrationScreen()
                    case .login:
                        LoginScreen()
                    case .stockCategoryList:
                        Text("Stock category list will be here")
                    case .stockCategoryDetail(let stockCategory):
                        StockDetailScreen(stockCategory: stockCategory)
                    }
                }
        }
        .environmentObject(StockModel())
        .environmentObject(AppState())
    }
}


#Preview {
        StockCategoryListScreenContainer()
}
