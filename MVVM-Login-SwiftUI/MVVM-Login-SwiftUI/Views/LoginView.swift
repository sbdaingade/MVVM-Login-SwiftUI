//
//  LoginView.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 19/12/21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 16) {
                Form {
                    Section(header: Text("Email")){
                        TextField("Email", text: $loginViewModel.credentials.email)
                            .autocapitalization(.none)
                    }
                    Section(header: Text("Password"),footer: Text("").foregroundColor(.red)){
                        SecureField("Password", text: $loginViewModel.credentials.password)
                            .autocapitalization(.none)
                    }
                    
                    if loginViewModel.showProgressView {
                        ProgressView()
                    }
                }.frame(height:200)
                
                Button("Log in") {
                    loginViewModel.login { success in
                        authentication.updateValidation(success: success)
                    }
                }.padding()
                Spacer()
            }
        }
        .navigationTitle("Login")
        .onLoadingState(loginViewModel.$loadingState) {
            ActivityIndicator()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @StateObject var loginViewModel = LoginViewModel()
    static var previews: some View {
        LoginView()
    }
}
