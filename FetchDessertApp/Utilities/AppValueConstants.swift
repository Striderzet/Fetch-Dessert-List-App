//
//  AppValueConstants.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation
import SwiftUI

/// Turns string into error
enum StringCastError: Error {
    case runtimeError(String)
}

/// Constant values that are used throughout the app
enum AppValueConstants {
    
    enum Numeric: CGFloat {
        case imageSize = 100
        case progressViewScale5, hstackSpacing = 5
        case progressViewScale3 = 3
        case spacing2 = 2
        case fontSize24 = 24
        case fontSize20, closeButtonSize = 20
        case fontSize18 = 18
        case fontSize15 = 15
        case fontSize12 = 12
        case imageCorner = 8
        case textMinScale = 0.3
        case textMinSCale05 = 0.5
    }
    
    enum AlphaNumeric: String {
        case instructions = "Instructions"
        case ingredient = "Ingredient"
        case measurement = "Measurement"
    }
    
    enum Logs: String {
        case mealListSuccess = "LOG: Meal list fetch complete"
        case mealListError = "LOG: There was an error with the meal list fetch: "
        case mealSuccess = "LOG: Meal fetch complete"
        case mealError = "LOG: There was an error with the meal fetch: "
        case apiCallSuccess = "LOG: Call Finished"
        case urlResponseError = "LOG: URL response error"
        case favoriteListUpdated = "LOG: Favorite list updated"
        case favoritedAdded = "LOG: Favorite meal added, ID:"
        case favoritedRemoved = "LOG: Favorite meal removed, ID:"
    }
    
    enum Labels: String {
        case recipes = "Recipes"
        case favorites = "Favorites"
        
        case noSignal = "No signal at the moment"
        case noFavorites = "No Favorites at the Moment"
    }
    
    enum SystemImageNames: String {
        case listStar = "list.star"
        case star
        case xmark
        case heart
        case sparkles
    }
    
    enum CoreDataConfig: String {
        case containerName = "FetchDessertApp"
    }
    
}
