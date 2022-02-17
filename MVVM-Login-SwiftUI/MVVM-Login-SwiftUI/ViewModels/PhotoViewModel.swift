//
//  PhotoViewModel.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 17/02/22.
//

import Foundation
import Combine

public class PhotoViewModel: ObservableObject, Identifiable {
    
    private var cancallables = Set<AnyCancellable>()
    @Published public var title: String
    @Published public var imageData: Data?
    private var photo: Photos
    private var urlString: String?
    init(withPhoto photo: Photos) {
        self.photo = photo
        self.title = photo.title
        self.urlString = photo.url
          ImageLoader(urlString: photo.url).didChange.sink(receiveValue: {[unowned self] data in
            self.imageData = data
          }).store(in: &cancallables)
    }
    
    
    deinit {
        cancallables.forEach{$0.cancel()}
    }
}
