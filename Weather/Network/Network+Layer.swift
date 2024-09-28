//
//  Network+Layer.swift
//  Weather
//
//  Created by Harsh Pranay on 28/09/24.
//

import Foundation
import Combine


enum NetworkError: Error {
    case invaildURL
    case decodingError(Error)
    case netwrokfailure(Error)
    case otherError
}

class NetworkLayer: ObservableObject {

    @Published var model: DataModel?
    @Published var error: NetworkError?

    func fetchRequest(_ url: String) {
        guard let url = URL(string: url) else {
            self.error = .invaildURL
            return
        }

        let cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: DataModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished :
                    break
                case .failure(let error) :
                    if let error = error as? DecodingError {
                        self.error = .decodingError(error)
                    } else {
                        self.error = .netwrokfailure(error)
                    }
                }
            },receiveValue: { [weak self] model in
                self?.model = model
            })

    }
}
