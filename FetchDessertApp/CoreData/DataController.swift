//
//  DataController.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/28/23.
//

import CoreData
import Foundation
import SwiftUI

final class DataController {
    
    // MARK: - Favorite store and load methods
    // These need to be static because the core data store cannot be dynamic, unless wrapped in an enum, which is doable.
    // For the sake of simplicity, they will be static for Favorites here now
    
    /// Store a favorited meal to the data store while updating the live list
    /// - Parameter meal: The meal to add to favorites
    /// - Parameter viewContext: The view context in which the data store is present
    static func storeFavorite(meal: Meal, fromViewContext viewContext: NSManagedObjectContext) {
        
        let dataStore = FavoriteMeals(context: viewContext)
        
        dataStore.strMeal = meal.strMeal
        dataStore.strMealThumb = meal.strMealThumb
        dataStore.idMeal = meal.idMeal
        
        // Attempt save action when complete
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - mealId: <#mealId description#>
    ///   - favoritesList: <#favoritesList description#>
    ///   - viewContext: <#viewContext description#>
    static func deleteFavorite(mealId: String,
                               favoritesList: FetchedResults<FavoriteMeals>,
                               fromViewContext viewContext: NSManagedObjectContext) {
        
        for meal in favoritesList {
            if meal.idMeal == mealId {
                viewContext.delete(meal)
            }
        }
        
        // Attempt save action when complete
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    /// The list that will be loaded at the start of the app
    /// - Parameter viewContext: The view context in which the data store is present
    static func loadFavorites(fromList favoritesList: FetchedResults<FavoriteMeals>) {
        
        var loadedList = [Int: Meal]()
        
        for meal in favoritesList {
            loadedList[Int(meal.idMeal ?? "0") ?? 0] = Meal(strMeal: meal.strMeal ?? "",
                                                            strMealThumb: meal.strMealThumb ?? "",
                                                            idMeal: meal.idMeal ?? "")
        }
        
        ReactivePublisher.shared.favoritesList.send(loadedList)
        
    }
}
