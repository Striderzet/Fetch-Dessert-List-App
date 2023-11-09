//
//  NetworkAPIConstants.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation

enum APIEndpoint {
    
    case getDesserts
    case getMealDetails(mealId: String)
    
    var value: String {
        switch self {
        case .getDesserts:
            return "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        case .getMealDetails(mealId: let mealId):
            return "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        }
    }
    
}
