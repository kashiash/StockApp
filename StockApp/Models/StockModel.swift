//
//  StockModel.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import Foundation
import StockSharedDTOs

class StockModel: ObservableObject {

    let httpClient = HTTPClient()
    func register(username: String, password: String) async throws -> RegisterResponseDTO {

        let registerData = ["username":username, "password":password]
        let resource = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
        let response = try await httpClient.load(resource)
        return response
    }

    func login (username:String, password:String) async throws -> LoginResponseDTO {
       let loginData = ["username":username, "password":password]
        let resource = try Resource(url: Constants.Urls.login, method: .post(JSONEncoder().encode(loginData)), modelType: LoginResponseDTO.self)

        let response = try await httpClient.load(resource)

        if response.error == false && response.token != nil && response.userId != nil {
            //save token to userdefaults
            let defaults = UserDefaults.standard
            defaults.set(response.token, forKey: "authToken")
            defaults.set(response.userId?.uuidString, forKey: "userId")
        }

        return response
    }
}
