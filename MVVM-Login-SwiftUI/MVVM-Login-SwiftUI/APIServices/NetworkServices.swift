//
//  NetworkServices.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 20/12/21.
//

import Foundation
class NetworkServices {
    static let shared = NetworkServices()
    private init(){}
    
    func login(credentials: Credentials,completion: @escaping (Result<Bool,Authentication.AuthenticationError>) -> Void) {
        
        let parameters = ["email":credentials.email,"password":credentials.password]
        
        var request = URLRequest(url: URL(string: "http://restapi.adequateshop.com/api/authaccount/login")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let postData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) {
            request.httpBody = postData
        }
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data,response,error in
            
            if error != nil {
                completion(.failure(Authentication.AuthenticationError.customError(error!.localizedDescription)))
                return
            }
            do {
                let user = try JSONDecoder().decode(User.self, from: data!)
                if user.message == "success" {
                    completion(.success(true))
                }else {
                    completion(.failure(Authentication.AuthenticationError.invalidCredentials))
                }
                
            } catch {
                completion(.failure(Authentication.AuthenticationError.customError("\(error.localizedDescription)")))
            }
            
        }.resume()
    }
    
    
    func getPhotos(completion: @escaping (Result<[Photos],Authentication.AuthenticationError>) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/photos")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data,response,error in
            
            if error != nil {
                completion(.failure(Authentication.AuthenticationError.customError(error!.localizedDescription)))
                return
            }
            do {
                
                let photos = try JSONDecoder().decode([Photos].self, from: data!)
                completion(.success(photos))
                
            } catch {
                completion(.failure(Authentication.AuthenticationError.customError("\(error.localizedDescription)")))
            }
            
        }.resume()
    }
}

