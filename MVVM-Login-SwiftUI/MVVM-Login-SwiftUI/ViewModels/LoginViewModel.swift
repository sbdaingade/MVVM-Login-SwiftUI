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
    private var cancallables = Set<AnyCancellable>()
    
    private let keychain = SKeychain()
    private let server = "www.google.com"
    @Published public private(set) var userCredentials: SKeychain.SKCredentials?
    
    @Published public private(set) var loadingState: LoadingState = LoadingState.idle
    
    public enum Input {
        case login((Bool) ->Void)
        case forgotPassword(email:String)
        case getCredetials
    }
    
    private(set) public var input = PassthroughSubject<Input, Never>()
    
    init() {
        input.sink{ [unowned self] action in
            switch action {
            case .login(let complition):
                self.login { success in
                    complition(success)
                }
            case .forgotPassword(let email):
                break
            case .getCredetials:
                userCredentials = nil
                do {
                    userCredentials = try self.keychain.readCredentials(server: self.server)
                    credentials.email = userCredentials?.email ?? ""
                    credentials.password = userCredentials?.password ?? ""
                }catch {
                    print(error.localizedDescription)
                }
            }
        } .store(in: &cancallables)
    }
    
    var loginDisable: Bool {
        if credentials.email.isEmpty || credentials.password.isEmpty {
            return true
        }else {
            return !(credentials.email.isValidForType(type: .email) && credentials.password.isValidForType(type: .password))
        }
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        loadingState = .loading
        NetworkServices.shared.login(credentials: credentials) { [unowned self](result:Result<Bool, Authentication.AuthenticationError>) in
            //   showProgressView = false
            switch result {
            case .success:
                DispatchQueue.main.async {
                    do {
                        let creditials = SKeychain.SKCredentials(email: credentials.email, password: credentials.password)
                        try keychain.addCredentials(creditials, server: self.server)
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                    loadingState = .idle
                    completion(true)
                }
            case .failure(let authError):
                DispatchQueue.main.async {
                    //   credentials = Credentials()
                    completion(false)
                    loadingState = .failed(authError.errorDescription ?? "Invalid credentials" )
                }
            }
        }
    }
    
    deinit {
        cancallables.forEach{$0.cancel()}
    }
}

