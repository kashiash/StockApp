//
//  AddStockItemScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 06/01/2024.
//

import SwiftUI
import StockSharedDTOs

struct AddStockItemScreen: View {
    // varaibles to enter data
    @State private var title: String = ""
    @State private var price: Double? = nil
    @State private var quantity: Double? = nil

    //An action that dismisses the current presentation.
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var model: StockModel


    var body: some View {
        //Main form to enter data
        Form {
            TextField("Title", text: $title)
            TextField("Price", value:  $price,format:.number)
            TextField("Quantity", value: $quantity,format:.number)
        }
        .navigationTitle("New stock item")
        // Buttons on top
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    Task{
                        await saveStockItem()
                    }
                }
                .disabled(!isFormValid)
            }
        }
    }

    // function to validate data before saving
    var  isFormValid : Bool {
        guard let price = price,
              let quantity = quantity else {
                return false
        }
      return  !title.isEmptyOrWhiteSpace && price > 0 && quantity > 0
    }

    // function to save data
    func saveStockItem() async {
        guard let category = model.stockCategory,
              let price = price,
              let quantity = quantity
        else { return }

     let requestDto = StockItemRequestDTO(title: title, price: price, quantity: quantity)
        do {
            try await model.saveStockItem(requestDto,stockCategoryId:  category.id)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack{
        AddStockItemScreen()
            .environmentObject(StockModel())
    }
}
