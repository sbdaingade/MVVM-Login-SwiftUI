//
//  ImageLoader.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 17/02/22.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {

    var didChange = PassthroughSubject<Data, Never>()
    var newData = Data() {
        didSet {
            didChange.send(newData)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 300
        let sessionShared = URLSession(configuration: config)
        
        let task = sessionShared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.newData = data
            }
        }
        task.resume()
    }
}
