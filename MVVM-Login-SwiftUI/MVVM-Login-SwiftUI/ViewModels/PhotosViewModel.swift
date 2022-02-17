//
//  PhotosViewModel.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 17/02/22.
//

import Foundation
import Combine

class PhotosViewModel: ObservableObject {
    
    @Published var showProgressView = false
    private var cancallables = Set<AnyCancellable>()
    @Published public private(set) var photos: [Photos] = []
    @Published public private(set) var loadingState: LoadingState = LoadingState.idle
    
    public enum Input {
        case getPhotos
    }
    
    @Published public var input: Input?
    
    init() {
        $input.compactMap{$0}.sink{ [unowned self] action in
            switch action {
            case .getPhotos:
                self.getAllphotos()
            }
        } .store(in: &cancallables)
    }
    
    private func getAllphotos() {
        showProgressView = true
        loadingState = .loading
        NetworkServices.shared.getPhotos() { [unowned self] (result:Result<[Photos], Authentication.AuthenticationError>) in
            //   showProgressView = false
            switch result {
            case .success(let allPhotos):
                DispatchQueue.main.async {
                    photos.removeAll()
                    photos = allPhotos
                    loadingState = .idle
                }
            case .failure(let error as Authentication.AuthenticationError?):
                DispatchQueue.main.async {
                    loadingState = .failed(error?.errorDescription ?? "Invalid request" )
                }
            }
        }
    }
    
    deinit {
        cancallables.forEach{$0.cancel()}
    }
}
