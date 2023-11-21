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
    
    @State var selectedMeal = MealDetailViewModel()
    @State var presentMeal = false
    
    @State private var selectedCategory = ListCategories.american.displayValue
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                Menu(content: {
                    
                    ForEach(ListCategories.allCases, id:\.self) { item in
                        Button(action: {
                            // change list header
                            selectedCategory = item.displayValue
                            
                            // refresh list
                            mealListViewModel.getMealList(withListCategory: item)
                        }, label: {
                            Text(item.displayValue)
                        })
                    }
                    
                }, label: {
                    Text(selectedCategory)
                        .foregroundColor(.black)
                        .font(.system(size: AppValueConstants.Numeric.fontSize24.rawValue).bold())
                        .padding(.top)
                })
                
                /// - Note: Attempted to place this in the ViewModel, but it slowed the loading of transitions
                if let meals = mealListViewModel.model?.meals {
                    
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
            .fullScreenCover(isPresented: $presentMeal, content: {
                MealDetailView(mealDetailViewModel: selectedMeal)
            })
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
