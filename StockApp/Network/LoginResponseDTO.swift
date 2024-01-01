//
//  LoginResponseDTO.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import Foundation

struct LoginResponseDTO :Codable {

    let error: Bool
    var reason: String? = nil
    var token: String? = nil
    var userId: UUID? = nil
}
