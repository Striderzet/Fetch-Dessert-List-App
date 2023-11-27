//
//  MealDetailView.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import SwiftUI

struct MealDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    /// - Note: This will be a param for when the view gets called to be presented
    @ObservedObject var mealDetailViewModel: MealDetailViewModel
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .center, spacing: AppValueConstants.Numeric.spacing2.rawValue) {
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .frame(width: AppValueConstants.Numeric.closeButtonSize.rawValue, height: AppValueConstants.Numeric.closeButtonSize.rawValue)
                    })
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        mealDetailViewModel.toggleFavorite() { complete in
                            if complete {
                                // I may want to do this after one second
                                //presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }, label: {
                        Image(systemName: "heart")
                            .foregroundColor(mealDetailViewModel.toggleFavoriteHeart ? .pink : .black)
                            .frame(width: AppValueConstants.Numeric.closeButtonSize.rawValue, height: AppValueConstants.Numeric.closeButtonSize.rawValue)
                    })
                    .padding(.trailing)
                    
                    
                }
                .padding()
                
                /// - Note: We are checking only for the first item in the array here because that is how the JSON response is setup here. We will always assume that each meal ID has only one meal for now
                if let meal = mealDetailViewModel.model?.meals.first {
                    
                    // Meal Heading
                    HStack {
                        Text(meal.strMeal)
                            .foregroundColor(.black)
                            .font(.system(size: AppValueConstants.Numeric.fontSize18.rawValue))
                            .minimumScaleFactor(AppValueConstants.Numeric.textMinScale.rawValue)
                            .padding()
                        
                        AsyncImageCustom(imageUrl: meal.strMealThumb ?? "")
                            .frame(width: AppValueConstants.Numeric.imageSize.rawValue, height: AppValueConstants.Numeric.imageSize.rawValue)
                            .cornerRadius(AppValueConstants.Numeric.imageCorner.rawValue)
                            .padding()
                    }
                    
                    // Instructions
                    Text(AppValueConstants.AlphaNumeric.instructions.rawValue)
                        .font(.system(size: AppValueConstants.Numeric.fontSize15.rawValue).bold())
                        .padding()
                    Divider()
                    Text(meal.strInstructions)
                        .font(.system(size: AppValueConstants.Numeric.fontSize12.rawValue))
                        .minimumScaleFactor(AppValueConstants.Numeric.textMinSCale05.rawValue)
                        .padding()
                    
                    // Here is where the ingredients will be setup
                    HStack {
                        Text(AppValueConstants.AlphaNumeric.ingredient.rawValue)
                            .font(.system(size: AppValueConstants.Numeric.fontSize15.rawValue).bold())
                            .padding()
                        Spacer()
                        Text(AppValueConstants.AlphaNumeric.measurement.rawValue)
                            .font(.system(size: AppValueConstants.Numeric.fontSize15.rawValue).bold())
                            .padding()
                    }
                    
                    Divider()
                    
                    mealDetailViewModel.retrievedIngredientsAndMeasurements()
                    
                } else {
                    VStack(alignment: .center) {
                        ProgressView()
                            .frame(width: AppValueConstants.Numeric.imageSize.rawValue, height: AppValueConstants.Numeric.imageSize.rawValue, alignment: .center)
                            .scaleEffect(AppValueConstants.Numeric.progressViewScale5.rawValue)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onReceive(ReactivePublisher.shared.favoritesList, perform: { list in
                if let stringId = self.mealDetailViewModel.model?.meals.first?.idMeal,
                   let id = Int(stringId),
                   list[id] != nil {
                    self.mealDetailViewModel.toggleFavoriteHeart = true
                } else {
                    self.mealDetailViewModel.toggleFavoriteHeart = false
                }
            })
                
        }
        
    }
    
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(mealDetailViewModel: MealDetailViewModel())
    }
}
