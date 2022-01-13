//
//  ViewModifiers.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 13/01/22.
//

import Foundation
import SwiftUI

struct LoadingStateModifier<IndicatorView: View>: ViewModifier {
    
    let loadingState: Published<LoadingState>.Publisher
    let activityIndicatorView: IndicatorView
    let blurContent: Bool
    
    @State private var showActivityIndicator: Bool = false
    @State private var errorMessage: IdentifiableObject<String>?
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: (showActivityIndicator && blurContent) ? 3 : 0)
            if showActivityIndicator {
                if !blurContent {
                    Color(.black)
                        .opacity(0.13)
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(1.0)
                }
                activityIndicatorView
            }
        }
        .alert(item: $errorMessage, content:{ error in
            Alert(title: Text("Error"), message: Text("\(error.value)"), dismissButton: nil)
        } )
        
        .onReceive(loadingState, perform: { loadingState in
            switch loadingState {
            case .idle:
                showActivityIndicator = false
            case .loading:
                showActivityIndicator = true
            case .failed(let errorString):
                showActivityIndicator = false
                errorMessage = IdentifiableObject(errorString)
            }
        })
    }
}

extension View {
    func onLoadingState<IndicatorView:View>(_ loadingState: Published<LoadingState>.Publisher, blurContent: Bool = false , activityView: () -> IndicatorView ) -> some View {
        return modifier(LoadingStateModifier(loadingState: loadingState, activityIndicatorView: activityView(), blurContent: blurContent).animation(.easeInOut))
    }
}
