//
//  NetworkAPIConstants.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation

enum URLConstnats: String {
    case scheme = "https"
    case host = "themealdb.com"
    case path = "/api/json/v1/1/"
}

enum APIEndpoint {
    
    case getDesserts
    case getMealDetails(mealId: String)
    
    /*var key: String {
        switch self {
        case .getDesserts:
            return "filter.php"
        case .getMealDetails(_):
            return "lookup.php"
        }
    }
    
    var value: String {
        switch self {
        case .getDesserts:
            return "c=Dessert"
        case .getMealDetails(mealId: let mealId):
            return "i=\(mealId)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: self.key, value: self.value)]
    }*/
    
    var value: String {
        switch self {
        case .getDesserts:
            return "filter.php?c=Dessert"
        case .getMealDetails(mealId: let mealId):
            return "lookup.php?i=\(mealId)"
        }
    }
    
}
