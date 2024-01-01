//
//  RegisterResponseDTO.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import Foundation

struct RegisterResponseDTO :Codable {

    let error: Bool
    var reason: String? = nil
}
