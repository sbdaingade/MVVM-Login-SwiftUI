//
//  NetworkServices.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 20/12/21.
//

import Foundation
class NetworkServices {
    static let shared = NetworkServices()
    
    func login(credentials: Credentials,
               completion: @escaping (Result<Bool,Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if credentials.password == "password" {
                completion(.success(true))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
}
