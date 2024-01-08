//
//  ErrorWrapper.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 08/01/2024.
//

import Foundation


struct ErrorWrapper : Identifiable {
   let id = UUID()
    let error: Error
    let guidance: String
}
