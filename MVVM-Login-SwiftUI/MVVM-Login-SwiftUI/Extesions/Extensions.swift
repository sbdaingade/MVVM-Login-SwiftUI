//
//  Extensions.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 16/01/22.
//

import Foundation

extension String{
    
    func isValidForType(type: Validation) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", type.description).evaluate(with: self)
    }
}

public enum Validation : CustomStringConvertible {
    case email
    case password
    
    public var description: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password:
            return "^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$"
        }
    }
}

public protocol UUIDIdetifiable: Identifiable {
    var id: UUID { get }
}

extension UUIDIdetifiable {
    public var id: UUID { UUID() }
}

public enum PasswordStatus {
    case empty
    case notStrongEnough
    case passwordNconfirmPasswordNotMatched
    case valid
}

public enum EmailErrorStatus {
    case empty
    case notValid
    case valid
}
