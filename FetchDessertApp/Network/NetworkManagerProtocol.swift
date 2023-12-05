//
//  NetworkManagerProtocol.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import Combine
import Foundation

protocol NetworkManagerProtocol {
    func makeCall<T: Decodable>(withRawData data: Data?, fromEndpoint endpoint: APIEndpoint, toType type: T.Type) -> Future<T, Error>
    func constructURLComponents(endpoint: APIEndpoint) -> URL
}
