//
//  NetworkManager.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Combine
import Foundation

/// This network manager will simply make API calls and return the type that is expected in the call
final class NetworkManager {
    
    static var cancellable = Set<AnyCancellable>()
    
    /// This will make the actual call and return the
    /// - Parameters:
    ///   - endpoint: The string of the URL API call
    ///   - type: The type that will be returned to a desired object
    /// - Returns: Future/Promise with object type and error
    static func makeCall<T: Decodable>(fromEndpoint endpoint: String,
                                       toType type: T.Type) -> Future<T, Error> {
        
        return Future { promise in
            
            var request = URLRequest(url: URL(string: endpoint) ?? URL(fileURLWithPath: ""))
            
            /// - Note: This would be setup by endpoint here, but to save time it will be static
            request.httpMethod = "GET"
            
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard response is HTTPURLResponse else {
                        throw (AppValueConstants.Logs.urlResponseError.rawValue as? Error)!
                    }
                    return data
                }
                .receive(on: DispatchQueue.main)
                .decode(type: T.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print(AppValueConstants.Logs.apiCallSuccess.rawValue)
                    case.failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: {
                    promise(.success($0))
                })
                .store(in: &cancellable)
            
        }
        
    }
    
}
