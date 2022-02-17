//
//  ContentView.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 19/12/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var photosViewModel = PhotosViewModel()
    
    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(photosViewModel.photos) { photo in
                    let viewModel = PhotoViewModel(withPhoto: photo)
                    PhotoViewCell(photoViewModel: viewModel)
                }
            }
            .padding([.leading,.trailing,.top,.bottom] ,5)
            .background(Color.gray)
        }
        .onAppear(perform: {
            photosViewModel.input = .getPhotos
        })
        .navigationTitle("Home")
        .onLoadingState(photosViewModel.$loadingState, blurContent: true) { ActivityIndicator()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
