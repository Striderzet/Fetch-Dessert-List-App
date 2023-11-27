//
//  MealListViewModel.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Combine
import Foundation
import SwiftUI

// MARK: - Production View Model

class MealListViewModel: MealListViewModelProtocol, ObservableObject {
    
    // MARK: - Values and init
    
    @Published var model: MealListModel?
    @Published var selectedCategoryText = ListCategories.american.displayValue
    @Published var selectedCategory = ListCategories.american
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        if model == nil {
            getMealList()
        }
    }
    
    // MARK: - Methods
    
    /// Normally, this list will be in it's own manager and will be able to be reused throughout the app limiting API calls. For the sake of space and simplicity, it will live here.
    func getMealList(withListCategory category: ListCategories = .american, withTestFileData fileData: Data? = nil) {
        
        // make the list nil for a possible reload. It will also be defaulted "American" fro the first load
        if model != nil {
            model = nil
        }
        
        NetworkManager.shared.makeCall(fromEndpoint: APIEndpoint.getMealList(mealCategory: category),
                                toType: MealListModel.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print(AppValueConstants.Logs.mealListSuccess.rawValue)
                case .failure(let error):
                    print(AppValueConstants.Logs.mealListError.rawValue+error.localizedDescription)
                }
                
            }, receiveValue: {
                self.model = $0
            })
            .store(in: &cancellable)
    }
    
}

// MARK: - Test View Model

class MealListViewModelTest: MealListViewModelProtocol {
    
    var model: MealListModel?
    
    init(testData: Data?) {
        if model == nil {
            getMealList(withTestFileData: testData)
        }
    }
    
    func getMealList(withListCategory category: ListCategories = .american, withTestFileData fileData: Data?) {
        model = try? JSONDecoder().decode(MealListModel.self, from: fileData!)
    }
}
