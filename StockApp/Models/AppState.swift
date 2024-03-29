//
//  AppState.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import Foundation
import StockSharedDTOs

enum StockError: Error {
    case login
}
enum Route: Hashable {
    case login
    case register
    case stockCategoryList
    case stockCategoryDetail(StockCategoryResponseDTO)
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
    @Published var errorWrapper: ErrorWrapper? 
}
