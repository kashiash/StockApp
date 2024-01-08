//
//  ErrorView.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 08/01/2024.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    var body: some View {
        VStack {
            Image(systemName: "bolt.badge.a")
                .font(.largeTitle)
                .foregroundColor(.red)
                .padding()
            Text("Error has occured in the application")
                .font(.headline)
                .padding(.bottom)
            Text(errorWrapper.error.localizedDescription)
            Text(errorWrapper.guidance)
                .font(.caption)
        }
        .padding()
    }
}

enum  SampleError: Error {
    case operationFailed
}

#Preview {

        ErrorView(errorWrapper: ErrorWrapper(error: SampleError.operationFailed, guidance: "Do something"))

}
