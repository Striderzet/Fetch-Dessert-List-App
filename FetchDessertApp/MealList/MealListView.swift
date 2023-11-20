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
        
        ScrollView {
            
            VStack {
                
                Text(AppValueConstants.AlphaNumeric.desserts.rawValue)
                    .foregroundColor(.black)
                    .font(.system(size: AppValueConstants.Numeric.fontSize24.rawValue).bold())
                
                mealListViewModel.retrievedMealList()
                
            }
            .fullScreenCover(isPresented: $mealListViewModel.presentMeal, content: {
                MealDetailView(mealDetailViewModel: mealListViewModel.selectedMeal)
            })
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
