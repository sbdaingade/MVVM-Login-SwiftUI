//
//  LoginViewModel.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 19/12/21.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
   
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?

    var loginDisable: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    func login(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        NetworkServices.shared.login(credentials: credentials) { [unowned self](result:Result<Bool, Authentication.AuthenticationError>) in
         showProgressView = false
            switch result {
            case .success:
                completion(true)
            case .failure(let authError):
                credentials = Credentials()
                error = authError
                completion(false)
            }
        }
    }
}

