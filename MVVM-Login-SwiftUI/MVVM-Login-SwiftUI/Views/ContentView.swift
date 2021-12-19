//
//  ContentView.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 19/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authentication: Authentication

    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
