//
//  StockAppApp.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 31/12/2023.
//

import SwiftUI

@main
struct StockAppApp: App {

    @StateObject private var model = StockModel()
    @StateObject private var appState = AppState()


    var body: some Scene {

        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "authToken")

        WindowGroup {
            NavigationStack(path: $appState.routes){
                Group{
                    if token == nil {
                        LoginScreen()
                    } else {
                        StockCategoryListScreen()
                    }
                }
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .register:
                            RegistrationScreen()
                        case .login:
                            LoginScreen()
                        case .stockCategoryList:
                            StockCategoryListScreen()
                        case .stockCategoryDetail(let stockCategory):
                            StockDetailScreen(stockCategory: stockCategory)
                        }
                    }
            }
                .environmentObject(model)
                .environmentObject(appState)
        }
    }
}
