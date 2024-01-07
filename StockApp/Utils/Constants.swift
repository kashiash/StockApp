//
//  Constants.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import Foundation

struct Constants {
    private static let baseUrlPath = "http://127.0.0.1:8080/api"

    struct Urls {
        static let register = URL(string: "\(baseUrlPath)/register")!
        static let login = URL(string: "\(baseUrlPath)/login")!

        static func saveStockCategoryBy(userId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/stock-categories")!
        }


        static func getStockCategoriesBy(userId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/stock-categories")!
        }

        static func deleteStockCategoriesBy(userId: UUID,categoryId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/stock-categories/\(categoryId)")!
        }

        static func saveStockItem(userId: UUID,categoryId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/stock-categories/\(categoryId)/stock-items")!
        }

        static func getStockItemsBy(userId: UUID,categoryId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/stock-categories/\(categoryId)/stock-items")!
        }

        static func deleteStockItem(userId: UUID,categoryId: UUID,itemId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/stock-categories/\(categoryId)/stock-items/\(itemId)")!
        }
    }
}

