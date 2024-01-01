//
//  LoginScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject private var model: StockModel

    @State private var username: String = ""
    @State private var password: String = ""

    @State private var errorMessage: String = ""

    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            HStack {
                Button("Login") {
                    Task {
                        await login()
                    }
                }
                .buttonStyle(.borderless)
                .disabled(!isFormValid)
            }
            Text(errorMessage)
        }
    }

    func login() async {
        do {
            let response = try await model.login(username: username, password: password)

            if response.error == false {

                // take user to login screen
            } else {
                errorMessage = response.reason ?? ""
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
            .environmentObject(StockModel())
    }
}
