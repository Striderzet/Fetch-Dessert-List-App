//
//  ReactivePublisher.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import Combine
import Foundation

class ReactivePublisher {
    
    static let shared = ReactivePublisher()
    
    // MARK: - Publishers
    
    // Network
    
    /// The apps network status will be defaulted to true until the app realizes its not online
    var appNetworkStatus = CurrentValueSubject<Bool, Never>(true)
    
    // Favorites
    
    var updateFavoritesList = PassthroughSubject<Meal, Never>()
    var favoritesList = CurrentValueSubject<[Int: Meal], Never>([:])
    
    // MARK: - Methods
    
    //-----
    
}
