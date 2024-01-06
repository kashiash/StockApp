//
//  AddStockItemScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 06/01/2024.
//

import SwiftUI

struct AddStockItemScreen: View {

    @State private var title: String = ""
    @State private var price: Double? = nil
    @State private var quantity: Double? = nil

    @Environment(\.dismiss) var dismiss

    var  isFormValid : Bool {
//        guard let price = price,
//              let quantity = quantity else {
//
//        }
        !title.isEmptyOrWhiteSpace && price! > 0 && quantity! > 0
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AddStockItemScreen()
}
