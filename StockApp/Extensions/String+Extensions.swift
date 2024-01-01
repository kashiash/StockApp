//
//  String+Extensions.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 31/12/2023.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
