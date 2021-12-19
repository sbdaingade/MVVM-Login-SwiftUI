//
//  UIApplicationExtension.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 19/12/21.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
