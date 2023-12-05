//
//  ReactiveSubscriber.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import Combine
import Foundation
import SwiftUI

class ReactiveSubscriber {
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        updateFavoritesList()
    }
    
    private func updateFavoritesList() {
        ReactivePublisher.shared.updateFavoritesList
            .sink(receiveValue: { meal, favoritesList, viewContext in
                
                var currentFavoritesList = ReactivePublisher.shared.favoritesList.value
                
                guard let mealId = Int(meal.idMeal) else {
                    return
                }
                
                if currentFavoritesList[mealId] == nil {
                    currentFavoritesList[mealId] = meal
                    DataController.storeFavorite(meal: meal, fromViewContext: viewContext)
                    print("\(AppValueConstants.Logs.favoritedAdded.rawValue)\(mealId)")
                } else {
                    currentFavoritesList.removeValue(forKey: mealId)
                    DataController.deleteFavorite(mealId: String(mealId),
                                                  favoritesList: favoritesList,
                                                  fromViewContext: viewContext)
                    print("\(AppValueConstants.Logs.favoritedRemoved.rawValue)\(mealId)")
                }
                
                ReactivePublisher.shared.favoritesList.send(currentFavoritesList)
            })
            .store(in: &cancellable)
    }
    
    
}
