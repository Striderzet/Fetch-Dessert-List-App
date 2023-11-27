//
//  ReactiveSubscriber.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import Combine
import Foundation

class ReactiveSubscriber {
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        updateFavoritesList()
    }
    
    private func updateFavoritesList() {
        ReactivePublisher.shared.updateFavoritesList
            .sink(receiveValue: { meal in
                
                var currentFavoritesList = ReactivePublisher.shared.favoritesList.value
                
                guard let mealId = Int(meal.idMeal) else {
                    return
                }
                
                if currentFavoritesList[mealId] == nil {
                    currentFavoritesList[mealId] = meal
                } else {
                    currentFavoritesList.removeValue(forKey: mealId)
                }
                
                ReactivePublisher.shared.favoritesList.send(currentFavoritesList)
            })
            .store(in: &cancellable)
    }
    
    
}
