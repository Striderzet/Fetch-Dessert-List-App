//
//  MealListComponent.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import SwiftUI

/// Component to facilitate the meal list throughout the app
struct MealListComponent: View {
    
    // Parameters
    @State var meals: [Meal]
    var isDynamic: Bool = false
    @ObservedObject var mealListViewModel: MealListViewModel = MealListViewModel()
    
    // Private
    @State private var selectedMeal = MealDetailViewModel()
    @State private var presentMeal = false
    
    let favoriteLabel = "Favorite"
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                if isDynamic {
                
                    Menu(content: {
                        
                        ForEach(ListCategories.allCases, id:\.self) { item in
                            Button(action: {
                                // change list header
                                mealListViewModel.selectedCategoryText = item.displayValue
                                
                                // refresh list
                                mealListViewModel.getMealList(withListCategory: item)
                            }, label: {
                                Text(item.displayValue)
                            })
                        }
                        
                    }, label: {
                        Text(mealListViewModel.selectedCategoryText)
                            .foregroundColor(.black)
                            .font(.system(size: AppValueConstants.Numeric.fontSize24.rawValue).bold())
                            .padding(.top)
                    })
                    
                } else {
                    // This list can possibly be many things, but for now it can only be favorite if not the main list
                    Text(favoriteLabel)
                        .foregroundColor(.black)
                        .font(.system(size: AppValueConstants.Numeric.fontSize24.rawValue).bold())
                        .padding(.top)
                }
                
                
                
                /// - Note: Attempted to place this in the ViewModel, but it slowed the loading of transitions
                if let meals = self.meals {
                    
                    ForEach(meals, id:\.self) { meal in
                        
                        Button(action: {
                            self.selectedMeal.getMeal(fromId: meal.idMeal) { complete in
                                if complete {
                                    self.presentMeal = true
                                } else {
                                    // Throw incomplete error here
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
            .fullScreenCover(isPresented: $presentMeal, content: {
                MealDetailView(mealDetailViewModel: selectedMeal)
            })
            
        }
        
    }
}

struct MealListComponent_Previews: PreviewProvider {
    static var previews: some View {
        MealListComponent(meals: [])
    }
}
