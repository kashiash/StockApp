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
        WindowGroup {
            NavigationStack(path: $appState.routes){
                RegistrationScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .register:
                            RegistrationScreen()
                        case .login:
                            LoginScreen()
                        case .stockCategoryList:
                            Text("Stock category list will be here")
                        }
                    }
            }
                .environmentObject(model)
                .environmentObject(appState)
        }
    }
}
