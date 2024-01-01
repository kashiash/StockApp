//
//  StockModel.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import Foundation

class StockModel: ObservableObject {

    let httpClient = HTTPClient()
    func register(username: String, password: String) async throws -> Bool {

        let registerData = ["username":username, "password":password]
        let resource = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
        let response = try await httpClient.load(resource)
        return !response.error
    }
}
