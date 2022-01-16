//
//  SKeychain.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 17/01/22.
//

import LocalAuthentication

public struct SKeychain {
    
    public struct SKCredentials: Equatable {
        public var email: String
        public var password: String
    }
    
    //MARK: -  Keychain errors handles
    
    public struct KeychainErrors: Error {
        var status: OSStatus
        
        var localizedDescription: String {
            
            if #available(iOS 11.3, *) {
                return SecCopyErrorMessageString(status, nil) as String? ?? "Unknown error."
            } else {
                return "Unknown error."
            }
        }
    }
    
    //MARK: -   add save keychain data
    
    func addCredentials( _  credentials : SKCredentials, server: String) throws {
        
        let user = credentials.email
        let password = credentials.password.data(using: .utf8)!
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: user,
                                    kSecAttrService as String: server,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainErrors(status: status)}
        
    }
    
    //MARK: -   read keychain data
    
    func readCredentials(server:String) throws -> SKCredentials {
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: server,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecUseOperationPrompt as String: "Access your password on the keychain",
                                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else { throw KeychainErrors(status: status)}
        
        guard let existingItem = item as? [String: Any],
              let passwordData =  existingItem[kSecValueData as String] as? Data,
              let passwordString = String(data: passwordData, encoding: String.Encoding.utf8),
              let user = existingItem[kSecAttrAccount  as String] as? String
        else {
            throw KeychainErrors(status: errSecInternalError)
        }
        return SKCredentials(email: user, password: passwordString)
    }
    
    //MARK: -   Delete keychain data

    
    func deleteCredentials(server: String) throws {
        
        let query : [String:Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrService as String: server]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess  else { throw KeychainErrors(status: status)}
    }
    
}
