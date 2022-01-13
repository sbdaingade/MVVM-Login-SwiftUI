//
//  LoadingState.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 13/01/22.
//

import Foundation
import Combine

public enum LoadingState: Equatable {
    case idle
    case loading
    case failed(String)
}

public struct IdentifiableObject<T: Hashable>: Identifiable {
    public var id: Int {
        return value.hashValue
    }
    
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
}
