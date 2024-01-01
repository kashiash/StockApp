//
//  StockAppApp.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 31/12/2023.
//

import SwiftUI

@main
struct StockAppApp: App {

    @StateObject private var model = StockModel
    var body: some Scene {
        WindowGroup {
            RegistrationScreen()
                .environmentObject(StockModel())
        }
    }
}
