//
//  StockItemResponseDTO+Extensions.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 06/01/2024.
//

import Foundation
import StockSharedDTOs


extension StockItemResponseDTO: Identifiable,Hashable {
    public static func == (lhs: StockItemResponseDTO, rhs: StockItemResponseDTO) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
