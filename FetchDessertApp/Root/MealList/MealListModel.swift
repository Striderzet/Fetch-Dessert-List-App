//
//  MealListModel.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation

// MARK: - This is the simple meal model for a meal entry from a simple list call by meal category

struct MealListModel: Codable, Hashable {
    let meals: [Meal]
}

struct Meal: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
