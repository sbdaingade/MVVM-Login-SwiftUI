//
//  Authentication.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 20/12/21.
//

import Foundation

class Authentication: ObservableObject {
 
    @Published var isValidated = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case customError(String)
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Either your email or password are incorrect. Please try again"
            case .customError(let error):
                return "\(error)"
            }
        }
    }
    
    func updateValidation(success: Bool) {
        //   withAnimation {
        isValidated = success
        //  }
    }
}
