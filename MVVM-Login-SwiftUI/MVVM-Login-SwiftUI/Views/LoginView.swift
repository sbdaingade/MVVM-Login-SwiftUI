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
            VStack (alignment: .center, spacing: 16) {
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
                
                Button(" Log in ") {
                    loginViewModel.input = .login({ isSuccess in
                        authentication.updateValidation(success: isSuccess)
                    })
                }.cornerRadius(10)
                .disabled(loginViewModel.loginDisable )
                .foregroundColor(loginViewModel.loginDisable ? .gray : .blue)
                Spacer()
            }
            .onLoadingState(loginViewModel.$loadingState) {
                ActivityIndicator()
            }
            .background(Color.init(.sRGBLinear, red: 242/255, green: 242/255, blue: 247/255, opacity: 1.0))
            .navigationTitle("Login")
            .onAppear {
                loginViewModel.input = .getCredetials
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @StateObject var loginViewModel = LoginViewModel()
    static var previews: some View {
        LoginView()
    }
}
