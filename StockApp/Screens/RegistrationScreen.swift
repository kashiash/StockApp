//
//  RegistrationScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 31/12/2023.
//

import SwiftUI
import StockSharedDTOs

struct RegistrationScreen: View {

    @EnvironmentObject private var model: StockModel
    @EnvironmentObject private var appState: AppState

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
                Spacer()
                Button("Login") {
                    appState.routes.append(.login)
                }
                .buttonStyle(.borderless)
            }
            Text(errorMessage)
        }
        .navigationTitle("Register User")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
    private func register() async  {
        errorMessage = ""
        do {
            let response = try await model.register(username: username, password: password)
            if response.error == false {

                // take user to login screen
                appState.routes.append(.login)
            } else {
                errorMessage = response.reason ?? ""
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct RegistrationScreenContainer: View {
    @StateObject private var model = StockModel()
    @StateObject private var appState = AppState()
    
    var body : some View {
        NavigationStack(path: $appState.routes) {
            RegistrationScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .register:
                        RegistrationScreen()
                    case .login:
                        LoginScreen()
                    case .stockCategoryList:
                        Text("Stock category list will be here")
                    case .stockCategoryDetail(let stockCategory):
                        StockDetailScreen(stockCategory: stockCategory)
                    }
                }
        }
        .environmentObject(StockModel())
        .environmentObject(AppState())
    }
}

#Preview {
    RegistrationScreenContainer()
}
