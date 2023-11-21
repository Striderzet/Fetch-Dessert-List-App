//
//  NetworkAPIConstants.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation

/// URL constants for scale and expansion for other sources
enum URLConstnats: String {
    case scheme = "https"
    case host = "themealdb.com"
    case path = "/api/json/v1/1/"
}

/// List categories with static values for the URL
enum ListCategories: String, CaseIterable {
    
    // Category By Area
    case american = "a=American"
    case mexican = "a=Mexican"
    case japanese = "a=Japanese"
    
    // Category by Cuisine
    case dessert = "c=Dessert"
    case breakfast = "c=Breakfast"
    case seafood = "c=Seafood"
    
    // Category by Ingredient
    case chicken = "i=Chicken"
    case beef = "i=Beef"
    case tofu = "i=Tofu"
    
    var displayValue: String {
        switch self {
        case .american:
            return "American"
        case .mexican:
            return "Mexican"
        case .japanese:
            return "Japanese"
        case .dessert:
            return "Dessert"
        case .breakfast:
            return "Breakfast"
        case .seafood:
            return "Seafood"
        case .chicken:
            return "Chicken"
        case .beef:
            return "Beef"
        case .tofu:
            return "Tofu"
        }
    }
}

/// Endpoint values for calling lists and details
enum APIEndpoint {
    
    case getMealList(mealCategory: ListCategories)
    case getMealDetails(mealId: String)
    
    /// This does not work with these URL's, but it needs to be here just in case
    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: self.key, value: self.value)]
    }
    
    var key: String {
        switch self {
        case .getMealList(_):
            return "filter.php"
        case .getMealDetails(_):
            return "lookup.php"
        }
    }
    
    var value: String {
        switch self {
        case .getMealList(mealCategory: let mealCategory):
            return mealCategory.rawValue
        case .getMealDetails(mealId: let mealId):
            return "i=\(mealId)"
        }
    }
    
    // ------------------------------------------------------
    
    
    // This is the working model
    var fullValueSuffix: String {
        switch self {
        case .getMealList(mealCategory: let mealCategory):
            return "filter.php?\(mealCategory.rawValue)"
        case .getMealDetails(mealId: let mealId):
            return "lookup.php?i=\(mealId)"
        }
    }
    
}
