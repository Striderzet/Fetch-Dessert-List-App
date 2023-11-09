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
                
                if let meals = mealListViewModel.model?.meals {
                    
                    ForEach(meals, id:\.self) { meal in
                        
                        Button(action: {
                            selectedMeal.getMeal(fromId: meal.idMeal) { complete in
                                if complete {
                                    presentMeal = true
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
                                
                                AsyncImage(imageUrl: meal.strMealThumb)
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
            .fullScreenCover(isPresented: $presentMeal, content: {
                MealDetailView(mealDetailViewModel: selectedMeal)
            })
            
        }
        
    }
    
    // MARK: - Private
    
    @State private var presentMeal = false
    @State private var selectedMeal = MealDetailViewModel()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
