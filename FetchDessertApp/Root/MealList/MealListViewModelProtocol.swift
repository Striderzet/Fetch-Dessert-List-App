//
//  MealListViewModelProtocol.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/20/23.
//

import Foundation

protocol MealListViewModelProtocol {
    var model: MealListModel? { get set }
    func getMealList(withListCategory category: ListCategories, withTestFileData fileData: Data?)
}
