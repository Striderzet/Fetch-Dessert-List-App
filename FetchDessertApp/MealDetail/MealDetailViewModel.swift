//
//  MealDetailViewModel.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Combine
import Foundation
import SwiftUI

// MARK: - Production View Model

class MealDetailViewModel: MealDetailViewModelProtocol, ObservableObject {
    
    // MARK: - Values
    
    @Published var model: MealDetailModel?
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Methods
    
    /// This will get the chosen meal to be presented in the view
    /// - Parameter id: The meal ID from the selected option
    /// - Parameter status: Mark if the call has successfully completed
    /// - Returns: Status of the calls end result
    func getMeal(withTestFileData fileData: Data? = nil, fromId id: String, status: @escaping(_ complete: Bool) -> ()) {
        NetworkManager.makeCall(fromEndpoint: APIEndpoint.getMealDetails(mealId: id),
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
    
    // MARK: - Views
    
    func retrievedIngredientsAndMeasurements() -> some View {
        return VStack {
            if let count = model?.meals[0].strIngredient?.count,
               let meal = model?.meals[0] {
                
                ForEach(1..<count, id:\.self) { index in
                    
                    HStack {
                        Text(meal.strIngredient?[index] ?? "")
                            .font(.system(size: AppValueConstants.Numeric.fontSize20.rawValue))
                            .minimumScaleFactor(AppValueConstants.Numeric.textMinSCale05.rawValue)
                            .padding()
                        Spacer()
                        Text(meal.strMeasure?[index] ?? "")
                            .font(.system(size: AppValueConstants.Numeric.fontSize20.rawValue))
                            .minimumScaleFactor(AppValueConstants.Numeric.textMinSCale05.rawValue)
                            .padding()
                    }
                    
                }
                
            }
        }
    }
    
}

// MARK: - Test View Model

class MealDetailViewModelTest: MealDetailViewModelProtocol {
    
    var model: MealDetailModel?
    
    init(data: Data) {
        getMeal(withTestFileData: data, fromId: "") { _ in }
    }
    
    func getMeal(withTestFileData fileData: Data?, fromId id: String, status: @escaping (Bool) -> ()) {
        model = try? JSONDecoder().decode(MealDetailModel.self, from: fileData!)
    }
    
}
