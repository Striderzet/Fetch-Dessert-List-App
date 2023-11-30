//
//  MealDetailViewModel.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Combine
import CoreData
import Foundation
import SwiftUI

// MARK: - Production View Model

class MealDetailViewModel: MealDetailViewModelProtocol, ObservableObject {
    
    // MARK: - Values
    
    @Published var model: MealDetailModel?
    @Published var toggleFavoriteHeart: Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        if let id = self.model?.meals.first?.idMeal,
           ReactivePublisher.shared.favoritesList.value[Int(id) ?? 0] != nil {
            toggleFavoriteHeart = true
        }
    }
    
    // MARK: - Methods
    
    /// This will get the chosen meal to be presented in the view
    /// - Parameter id: The meal ID from the selected option
    /// - Parameter status: Mark if the call has successfully completed
    /// - Returns: Status of the calls end result
    func getMeal(withTestFileData fileData: Data? = nil, fromId id: String, status: @escaping(_ complete: Bool) -> ()) {
        NetworkManager.shared.makeCall(fromEndpoint: APIEndpoint.getMealDetails(mealId: id),
                                toType: MealDetailModel.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print(AppValueConstants.Logs.mealSuccess.rawValue)
                case .failure(let error):
                    print("\(AppValueConstants.Logs.mealSuccess.rawValue): \(error.localizedDescription) with full error: \(error)")
                    status(false)
                }
            }, receiveValue: {
                self.model = $0
                status(true)
            })
            .store(in: &cancellable)
    }
    
    /// This will toggle favorite if the ID exists or not
    /// - Parameter mealId: The ID that needs to be toggled
    func toggleFavorite(fromViewContext viewContext: NSManagedObjectContext, favoritesList: FetchedResults<FavoriteMeals>, complete: @escaping(_ done: Bool) -> ()) {
        if let currentMeal = self.model?.meals.first {
            let meal = Meal(strMeal: currentMeal.strMeal,
                            strMealThumb: currentMeal.strMealThumb ?? "",
                            idMeal: currentMeal.idMeal)
            ReactivePublisher.shared.updateFavoritesList.send((meal, favoritesList, viewContext))
            complete(true)
        }
    }
    
    // MARK: - Views
    
    
    /// Shows all ingredients and measurements from all that are stored in array from decoding the JSON Data
    /// - Returns: List of ingredients and measurements in a SwiftUI View
    func retrievedIngredientsAndMeasurements() -> some View {
        return Group {
            if let count = model?.meals[0].strIngredient?.count,
               let meal = model?.meals[0] {
                
                ForEach(1..<count, id:\.self) { index in
                    
                    return HStack {
                        Text(meal.strIngredient?[index] ?? "")
                            .font(.system(size: AppValueConstants.Numeric.fontSize12.rawValue))
                            .minimumScaleFactor(AppValueConstants.Numeric.textMinSCale05.rawValue)
                            .padding()
                        Spacer()
                        Text(meal.strMeasure?[index] ?? "")
                            .font(.system(size: AppValueConstants.Numeric.fontSize12.rawValue))
                            .minimumScaleFactor(AppValueConstants.Numeric.textMinSCale05.rawValue)
                            .padding()
                    }
                    
                }
                
            }
        }
    }
    
}

