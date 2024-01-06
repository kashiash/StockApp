//
//  StockCategoryResponseDto+Extensions.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 04/01/2024.
//

import Foundation
import StockSharedDTOs

extension StockCategoryResponseDTO : Identifiable ,Hashable {
    public static func == (lhs: StockCategoryResponseDTO, rhs: StockCategoryResponseDTO) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
