//
//  NetworkReachabilityPublisher.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/27/23.
//

import Combine
import Foundation
import Network

///Network status labels
enum NetworkStatus: String {
    case connected
    case disconnected
    
    case monitor = "Monitor"
}

/// Observer and publisher for app's lifecycle network status
class NetworkReachabilityMonitor: ObservableObject {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: NetworkStatus.monitor.rawValue)
    
    init() {
        monitor.pathUpdateHandler = { path in
            
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    ReactivePublisher.shared.appNetworkStatus.send(true)
                } else {
                    ReactivePublisher.shared.appNetworkStatus.send(false)
                }
            }
            
        }
        monitor.start(queue: queue)
    }
}
