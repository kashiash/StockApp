//
//  AddStockCategoryScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 02/01/2024.
//

import SwiftUI
import StockSharedDTOs

struct AddStockCategoryScreen: View {

    @EnvironmentObject private var model: StockModel
    
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
        let categoryDTO = StockCategoryRequestDTO(title: title, colorCode: colorCode)

        do {
            try await model.saveStockCategory(categoryDTO)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

}

#Preview {
    NavigationStack {
        AddStockCategoryScreen()
            .environmentObject(StockModel())
    }
}
