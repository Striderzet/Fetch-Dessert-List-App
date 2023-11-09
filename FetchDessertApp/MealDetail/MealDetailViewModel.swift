//
//  MealDetailViewModel.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Combine
import Foundation

class MealDetailViewModel: ObservableObject {
    
    @Published var model: MealDetailModel?
    
    private var cancellable = Set<AnyCancellable>()
    
    /// This will get the chosen meal to be presented in the view
    /// - Parameter id: The meal ID from the selected option
    /// - Parameter status: Mark if the call has successfully completed
    /// - Returns: Status of the calls end result
    func getMeal(fromId id: String, status: @escaping(_ complete: Bool) -> ()) {
        NetworkManager.makeCall(fromEndpoint: APIEndpoint.getMealDetails(mealId: id).value,
                                toType: MealDetailModel.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print(AppValueConstants.Logs.mealSuccess.rawValue)
                case .failure(let error):
                    print(AppValueConstants.Logs.mealSuccess.rawValue+error.localizedDescription)
                    status(false)
                }
            }, receiveValue: {
                self.model = $0
                status(true)
            })
            .store(in: &cancellable)
    }
    
}
