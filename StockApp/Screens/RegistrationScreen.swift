//
//  RegistrationScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 31/12/2023.
//

import SwiftUI

struct RegistrationScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""

 //   private let httpClient = HTTPClient()

    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && password.count >= 6 && password.count <= 10
    }
    var body: some View {
        Form {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            HStack {
                Button("Register") {
                    Task {
                        await register()
                    }
                }
                .buttonStyle(.borderless)
                .disabled(!isFormValid)
            }
        }
    }
    private func register() async {
    }

//    private func register() async {
//        let resource = Resource(url: <#T##URL#>, method: <#T##HTTPMethod#>, modelType: <#T##_.Type#>)
//        httpClient.load(resource)
//    }
}

#Preview {
    RegistrationScreen()
        .environmentObject(StockModel())
}
