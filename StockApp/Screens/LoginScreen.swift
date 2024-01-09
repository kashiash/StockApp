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

    @FocusState private var focusedField: FocusedField?

    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }

    var body: some View {
        VStack {
            Text("Login here")
                .font(.system(size: 30,weight: .bold))
                .foregroundColor(Color("PrimaryBlue"))
                .padding(.bottom)

            Text("Welcome back you have been missed!")
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
                Button{
                    Task {
                        await login()
                    }
                } label: {
                    Text("Login")
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
                    appState.routes.append(.register)
                } label: {
                    Text("Create new account")
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
