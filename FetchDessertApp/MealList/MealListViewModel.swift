//
//  MealListViewModel.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Combine
import Foundation

class MealListViewModel: ObservableObject {
    
    @Published var model: MealListModel?
    
    init() {
        if model == nil {
            getMealList()
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    /// Normally, this list will be in it's own manager and will be able to be reused throughout the app limiting API calls. For the sake of space and simplicity, it will live here.
    private func getMealList() {
        NetworkManager.makeCall(fromEndpoint: APIEndpoint.getDesserts.value,
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
