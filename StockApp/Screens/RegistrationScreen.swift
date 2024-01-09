//
//  RegistrationScreen.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 31/12/2023.
//

import SwiftUI
import StockSharedDTOs

enum FocusedField {
    case username
    case password
}

struct RegistrationScreen: View {

    @EnvironmentObject private var model: StockModel
    @EnvironmentObject private var appState: AppState

    @State private var username: String = ""
    @State private var password: String = ""

    @State private var errorMessage: String = ""

    @FocusState private var focusedField: FocusedField?

 //   private let httpClient = HTTPClient()

    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && password.count >= 6 && password.count <= 10
    }
    var body: some View {
        VStack {
            Text("Register here")
                .font(.system(size: 30,weight: .bold))
                .foregroundColor(Color("PrimaryBlue"))
                .padding(.bottom)

            Text("Create new account so you can use the best app on World!")
                .font(.system(size: 16,weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.bottom)

            TextField("Username", text: $username)
                .focused($focusedField,equals: .username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color("SecondaryBlue"))
                .cornerRadius(12)
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(focusedField == .username ? Color(.blue) : .white, lineWidth: 3)
                )
                .padding(.horizontal)
            SecureField("Password", text: $password)
                .focused($focusedField,equals: .password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color("SecondaryBlue"))
                .cornerRadius(12)
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(focusedField == .password ? Color(.blue) : .white, lineWidth: 3)
                )
                .padding(.horizontal)
            VStack {
                Button {
                    Task {
                        await register()
                    }
                } label: {
                    Text("Register")
                        .font(.system(size: 20,weight: .semibold))
                        .foregroundColor(.white)

                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("PrimaryBlue"))
                .cornerRadius(12)
                .padding()
                .disabled(!isFormValid)
             //   Spacer()
                Button {
                    appState.routes.append(.login)
                } label: {
                    Text("Already have an account")
                        .font(.system(size: 20,weight: .semibold))
                        .foregroundColor(.gray)
                }
                .buttonStyle(.borderless)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
               // .background(Color("PrimaryBlue"))
                .cornerRadius(12)
                .padding()
            }
            Text(errorMessage)
        }

        .navigationBarBackButtonHidden()

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
