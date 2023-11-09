//
//  AppValueConstants.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation
import SwiftUI

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
        case desserts = "Desserts"
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
    }
    
}
