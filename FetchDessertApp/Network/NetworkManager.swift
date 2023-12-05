//
//  NetworkManager.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Combine
import Foundation

// MARK: - Production Class

/// This network manager will simply make API calls and return the type that is expected in the call
class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    var cancellable = Set<AnyCancellable>()
    
    /// This will make the actual call and return the
    /// - Parameters:
    ///   - endpoint: The string of the URL API call
    ///   - type: The type that will be returned to a desired object
    /// - Returns: Future/Promise with object type and error
    func makeCall<T: Decodable>(withRawData data: Data? = nil,
                                fromEndpoint endpoint: APIEndpoint,
                                toType type: T.Type) -> Future<T, Error> {
        
        return Future { promise in
            
            var request = URLRequest(url: self.constructURLComponents(endpoint: endpoint))
            
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
                .store(in: &self.cancellable)
            
        }
        
    }
    
    /// This is for potential URL abstraction in the future
    internal func constructURLComponents(endpoint: APIEndpoint) -> URL {
        
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

// MARK: - Test Class

class NetworkManagerTest: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    func makeCall<T: Decodable>(withRawData data: Data?, fromEndpoint endpoint: APIEndpoint, toType type: T.Type) -> Future<T, Error> {
        return Future { promise in
            let newType = try? JSONDecoder().decode(T.self, from: data!)
            promise(.success(newType!))
        }
    }
    
    func constructURLComponents(endpoint: APIEndpoint) -> URL {
        var components = URLComponents()
        components.scheme = URLConstnats.scheme.rawValue
        components.host = URLConstnats.host.rawValue
        components.path = URLConstnats.path.rawValue
        let completeURL = (components.url?.absoluteString ?? "")+endpoint.fullValueSuffix
        return URL(string: completeURL) ?? URL(fileURLWithPath: "")
    }
    
}

