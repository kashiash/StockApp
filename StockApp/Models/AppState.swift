//
//  AppState.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import Foundation


enum Route: Hashable {
    case login
    case register
    case stockCategoryList
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
}
