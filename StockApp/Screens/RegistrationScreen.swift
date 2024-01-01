//
//  RegistrationScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 31/12/2023.
//

import SwiftUI

struct RegistrationScreen: View {

    @EnvironmentObject private var model: StockModel
    
    @State private var username: String = ""
    @State private var password: String = ""

    @State private var errorMessage: String = ""

 //   private let httpClient = HTTPClient()

    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && password.count >= 6 && password.count <= 10
    }
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
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
            Text(errorMessage)
        }
    }
    private func register() async  {
        errorMessage = ""
        do {
            let response = try await model.register(username: username, password: password)
            if response.error == false {

                // take user to login screen
            } else {
                errorMessage = response.reason ?? ""
            }
        } catch {
            errorMessage = error.localizedDescription
        }
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
