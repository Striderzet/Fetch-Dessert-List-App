//
//  ContentView.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import SwiftUI

struct MealListView: View {
    
    /// - Note: The list will be populated as soon as the object is initialized
    @ObservedObject var mealListViewModel = MealListViewModel()
    
    var body: some View {
        
        if let meals = mealListViewModel.model?.meals {
        
            MealListComponent(meals: meals,
                              isDynamic: true,
                              mealListViewModel: mealListViewModel)
            
        } else {
            
            if !ReactivePublisher.shared.appNetworkStatus.value {
                Text(AppValueConstants.Labels.noSignal.rawValue)
                    .onReceive(ReactivePublisher.shared.appNetworkStatus, perform: {
                        if $0 {
                            // Refresh when back on line. This needs to be done here to keep the refresh local
                            mealListViewModel.getMealList(withListCategory: mealListViewModel.selectedCategory)
                        }
                    })
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
