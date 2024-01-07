//
//  StockModel.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import Foundation
import StockSharedDTOs

@MainActor
class StockModel: ObservableObject {

    @Published var stockCategories: [StockCategoryResponseDTO] = []
    @Published var stockCategory: StockCategoryResponseDTO?
    @Published var stockItems: [StockItemResponseDTO] = []

    let httpClient = HTTPClient()
    func register(username: String, password: String) async throws -> RegisterResponseDTO {

        let registerData = ["username":username, "password":password]
        let resource = try Resource(url: Constants.Urls.register,
                                    method: .post(JSONEncoder().encode(registerData)),
                                    modelType: RegisterResponseDTO.self)

        let response = try await httpClient.load(resource)
        return response
    }

    func login (username:String, password:String) async throws -> LoginResponseDTO {
        let loginData = ["username":username, "password":password]
        let resource = try Resource(url: Constants.Urls.login,
                                    method: .post(JSONEncoder().encode(loginData)),
                                    modelType: LoginResponseDTO.self)

        let response = try await httpClient.load(resource)

        if response.error == false && response.token != nil && response.userId != nil {
            //save token to userdefaults
            let defaults = UserDefaults.standard
            defaults.set(response.token, forKey: "authToken")
            defaults.set(response.userId?.uuidString, forKey: "userId")
        }

        return response
    }

    func saveStockCategory(_ stockCategoryDTO: StockCategoryRequestDTO ) async throws {

        guard     let userId = UserDefaults.standard.userId
        else {
            return
        }

        let resource = try Resource(url: Constants.Urls.saveStockCategoryBy(userId: userId),
                                    method: .post(JSONEncoder().encode(stockCategoryDTO)),
                                    modelType: StockCategoryResponseDTO.self)

        let category = try await httpClient.load(resource)
        stockCategories.append(category)

    }

    func deleteStockItem(stockCategoryId: UUID, stockItemId: UUID) async throws {
        guard     let userId = UserDefaults.standard.userId
        else {
            return
        }

        let resource = Resource(url: Constants.Urls.deleteStockItem(userId: userId, categoryId: stockCategoryId,itemId: stockItemId),
                                    method: .delete,
                                    modelType: StockItemResponseDTO.self)

        let item = try await httpClient.load(resource)

        stockItems = stockItems.filter {$0.id != item.id}
    }

    func deleteStockCategory(stockCategoryId: UUID) async throws {

        guard     let userId = UserDefaults.standard.userId
        else {
            return
        }


        let resource = Resource(url: Constants.Urls.deleteStockCategoriesBy(userId: userId, categoryId: stockCategoryId),
                                    method: .delete,
                                    modelType: StockCategoryResponseDTO.self)

        let category = try await httpClient.load(resource)

        stockCategories = stockCategories.filter {$0.id != category.id}

    }

    func getStockCategories() async throws {

        guard let userId = UserDefaults.standard.userId else {
            return
        }
        print("user: \(userId)")
        let resource = Resource(url: Constants.Urls.getStockCategoriesBy(userId: userId),
                                    modelType: [StockCategoryResponseDTO].self)

        stockCategories = try await httpClient.load(resource)

        print("items \(stockCategories.count)")

    }

    func saveStockItem(_ stockItemDTO: StockItemRequestDTO , stockCategoryId: UUID) async throws {
        guard let userId = UserDefaults.standard.userId else {
            return
        }

        let resource = try Resource(url: Constants.Urls.saveStockItem(userId: userId, categoryId: stockCategoryId),
                                    method: .post(JSONEncoder().encode(stockItemDTO)),
                                    modelType: StockItemResponseDTO.self)

        let category = try await httpClient.load(resource)
        stockItems.append(category)
    }

    func populateStockItemsBy(stockcategoryId:UUID)  async throws {

        guard let userId = UserDefaults.standard.userId else {
            print("no user")
            return
        }
        print("user: \(userId)")

        let resource = Resource(url: Constants.Urls.getStockItemsBy(userId: userId,categoryId: stockcategoryId),
                                    modelType: [StockItemResponseDTO].self)

        stockItems = try await httpClient.load(resource)

        print("items \(stockItems.count)")
    }
}
