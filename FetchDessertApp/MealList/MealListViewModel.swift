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
    @Published var selectedMeal = MealDetailViewModel()
    @Published var presentMeal = false
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        if model == nil {
            getMealList()
        }
    }
    
    // MARK: - Methods
    
    /// Normally, this list will be in it's own manager and will be able to be reused throughout the app limiting API calls. For the sake of space and simplicity, it will live here.
    func getMealList(withTestFileData fileData: Data? = nil) {
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
    
    // MARK: - View Components
    
    func retrievedMealList() -> some View {
        
        return VStack {
        
        if let meals = model?.meals {
            
            ForEach(meals, id:\.self) { meal in
                
                Button(action: {
                    self.selectedMeal.getMeal(fromId: meal.idMeal) { complete in
                        if complete {
                            self.presentMeal = true
                        }
                    }
                }, label: {
                    HStack(spacing: AppValueConstants.Numeric.hstackSpacing.rawValue) {
                        Text(meal.strMeal)
                            .foregroundColor(.black)
                            .font(.system(size: AppValueConstants.Numeric.fontSize20.rawValue))
                            .minimumScaleFactor(AppValueConstants.Numeric.textMinScale.rawValue)
                            .lineLimit(1)
                            .padding()
                        
                        Spacer()
                        AsyncImageCustom(imageUrl: meal.strMealThumb)
                            .frame(width: AppValueConstants.Numeric.imageSize.rawValue, height: AppValueConstants.Numeric.imageSize.rawValue)
                            .cornerRadius(AppValueConstants.Numeric.imageCorner.rawValue)
                            .padding()
                    }
                })
                
                Divider()
                
            }
            
        } else {
            VStack(alignment: .center) {
                ProgressView()
                    .frame(width: AppValueConstants.Numeric.imageSize.rawValue, height: AppValueConstants.Numeric.imageSize.rawValue, alignment: .center)
                    .scaleEffect(3)
            }
        }
            
        }
        
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
    
    func getMealList(withTestFileData fileData: Data?) {
        model = try? JSONDecoder().decode(MealListModel.self, from: fileData!)
    }
}
