//
//  ColorSelector.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 02/01/2024.
//

import Foundation
import SwiftUI

enum Colors: String, CaseIterable {
    case red = "#FF0000"
    case  green = "#00FF00"
    case   blue = "#0000FF"

    case   orange = "#FFA500"
    case    purple = "#800080"
    case    cyan = "#00FFFF"
    case    indigo = "#4B0082"
//         teal = "#008080",
//         brown = "#A52A2A",
//         gray = "#808080",
//
//         magenta = "#FF00FF",
//         olive = "#808000",
//         maroon = "#800000"

    var colorName: String {
        return rawValue
    }

    var hexValue: String {
        return rawValue
    }
}

struct ColorSelector: View {

    @Binding var colorCode: String

    var body: some View {
        HStack {
            ForEach(Colors.allCases, id: \.rawValue) { color in
                VStack {
                    Image(systemName: colorCode == color.rawValue ? "record.circle.fill" : "circle.fill")
                        .font(.title)
                        .foregroundColor(Color.fromHex(color.rawValue))
                        .clipShape(Circle())
                        .onTapGesture {
                            colorCode = color.rawValue
                        }
                }

            }
        }
    }
}

#Preview {
    ColorSelector(colorCode:.constant("#4B0082"))
}
