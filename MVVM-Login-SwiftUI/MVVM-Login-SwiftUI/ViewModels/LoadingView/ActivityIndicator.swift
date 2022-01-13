//
//  ActivityIndicator.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 13/01/22.
//

import SwiftUI

struct ActivityIndicator: View {
    
    var type: ActivityIndicatorType? = nil
    
    enum ActivityIndicatorType: CustomStringConvertible {
        case loading
        case customText(String)
        
        var description: String {
            switch self {
            case .loading:
                return "Loading..."
            case .customText(let newTitle):
                return newTitle
            }
        }
    }
    
    var body: some View {
        ProgressView(type?.description ?? ActivityIndicatorType.loading.description)
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .foregroundColor(.blue)
            .font(.subheadline)
            .padding(EdgeInsets(top: 24, leading: 56, bottom: 24, trailing: 56))
            .background(Color.init(.sRGBLinear, white: 1.0, opacity: 0.8))
            .cornerRadius(20.0)
            .shadow(color: .black, radius: 4, x: 2, y: 2)
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
