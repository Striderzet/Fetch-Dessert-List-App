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
    static func makeCall<T: Decodable>(fromEndpoint endpoint: APIEndpoint,
                                       toType type: T.Type) -> Future<T, Error> {
        
        return Future { promise in
            
            var request = URLRequest(url: constructURLComponents(endpoint: endpoint))
            
            /// - Note: This would be setup by endpoint here, but to save time it will be static
            request.httpMethod = "GET"
            
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard response is HTTPURLResponse else {
                        throw StringCastError.runtimeError(AppValueConstants.Logs.urlResponseError.rawValue)
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
    
    /// This is for potential URL abstraction in the future
    static private func constructURLComponents(endpoint: APIEndpoint) -> URL {
        
        var components = URLComponents()
        components.scheme = URLConstnats.scheme.rawValue
        components.host = URLConstnats.host.rawValue
        components.path = URLConstnats.path.rawValue
        
        // These two can be switch based on the endpoint being used. This will help with scale and expansion of the API
        //components.queryItems = endpoint.queryItems
        
        let completeURL = (components.url?.absoluteString ?? "")+endpoint.fullValueSuffix
        
        return URL(string: completeURL) ?? URL(fileURLWithPath: "")
        
    }
    
}

/// Turns string into error
enum StringCastError: Error {
    case runtimeError(String)
}
