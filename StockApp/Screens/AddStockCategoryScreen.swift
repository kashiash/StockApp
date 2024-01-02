//
//  AddStockCategoryScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 02/01/2024.
//

import SwiftUI

struct AddStockCategoryScreen: View {

    @State private var title: String = ""
    @State private var colorCode: String = "#F6DDCC"

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            TextField("Title",text: $title )
            ColorSelector(colorCode: $colorCode)
        }
        .navigationTitle("New Category")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button ("Save") {
                    Task {
                        await saveStockcategory()
                    }
                }
                .disabled(!isFormValid)
            }
        }
    }

    var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }
    func saveStockcategory() async {

    }

}

#Preview {
    NavigationStack {
        AddStockCategoryScreen()
    }
}
