//
//  LoginScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 01/01/2024.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject private var model: StockModel
    @EnvironmentObject private var appState: AppState

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
                Spacer()
                Button("Register") {
                    appState.routes.append(.register)
                }
            }
            Text(errorMessage)

        }
        .navigationTitle("Login User")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .sheet(item: $appState.errorWrapper) { errorWrapper in

            ErrorView(errorWrapper: errorWrapper)
                .presentationDetents([.medium])
        }
    }

    func login() async {
        do {
            let response = try await model.login(username: username, password: password)

            if response.error == false {

                // take user to category screen
                appState.routes.append(.stockCategoryList)
            } else {
                //errorMessage = response.reason ?? ""
                appState.errorWrapper = ErrorWrapper(error: StockError.login, guidance: response.reason ?? "")
            }
        } catch {
            // errorMessage = error.localizedDescription
            appState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
            .environmentObject(StockModel())
            .environmentObject(AppState())
    }
}
