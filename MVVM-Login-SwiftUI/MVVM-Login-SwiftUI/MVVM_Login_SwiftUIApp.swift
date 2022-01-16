//
//  MVVM_Login_SwiftUIApp.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 19/12/21.
//

import SwiftUI

@main
struct MVVM_Login_SwiftUIApp: App {
    @StateObject var authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authentication.isValidated {
                    ContentView()
                        .environmentObject(authentication)
                } else {
                    LoginView()
                        .environmentObject(authentication)
                }
            }
        }
    }
}

