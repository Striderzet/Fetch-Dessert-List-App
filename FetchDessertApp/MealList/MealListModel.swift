//
//  MealListModel.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation

struct MealListModel: Codable, Hashable {
    var meals: [Meal]
}

struct Meal: Codable, Hashable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}
