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
    @StateObject var mealDetailViewModel: MealDetailViewModel
    
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
                        
                        AsyncImage(imageUrl: meal.strMealThumb ?? "")
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
                    
                    /// - Note: Placed in groups to get past the "10 views per" SwiftUI rule
                    Group {
                        ingredientAndMeasurement(meal.strIngredient1, meal.strMeasure1)
                        ingredientAndMeasurement(meal.strIngredient2, meal.strMeasure2)
                        ingredientAndMeasurement(meal.strIngredient3, meal.strMeasure3)
                        ingredientAndMeasurement(meal.strIngredient4, meal.strMeasure4)
                        ingredientAndMeasurement(meal.strIngredient5, meal.strMeasure5)
                        ingredientAndMeasurement(meal.strIngredient6, meal.strMeasure6)
                        ingredientAndMeasurement(meal.strIngredient7, meal.strMeasure7)
                        ingredientAndMeasurement(meal.strIngredient8, meal.strMeasure8)
                        ingredientAndMeasurement(meal.strIngredient9, meal.strMeasure9)
                        ingredientAndMeasurement(meal.strIngredient10, meal.strMeasure10)
                    }
                    
                    Group {
                        ingredientAndMeasurement(meal.strIngredient11, meal.strMeasure11)
                        ingredientAndMeasurement(meal.strIngredient12, meal.strMeasure12)
                        ingredientAndMeasurement(meal.strIngredient13, meal.strMeasure13)
                        ingredientAndMeasurement(meal.strIngredient14, meal.strMeasure14)
                        ingredientAndMeasurement(meal.strIngredient15, meal.strMeasure15)
                        ingredientAndMeasurement(meal.strIngredient16, meal.strMeasure16)
                        ingredientAndMeasurement(meal.strIngredient17, meal.strMeasure17)
                        ingredientAndMeasurement(meal.strIngredient18, meal.strMeasure18)
                        ingredientAndMeasurement(meal.strIngredient19, meal.strMeasure19)
                        ingredientAndMeasurement(meal.strIngredient20, meal.strMeasure20)
                    }
                    
                    
                } else {
                    VStack(alignment: .center) {
                        ProgressView()
                            .frame(width: AppValueConstants.Numeric.imageSize.rawValue, height: AppValueConstants.Numeric.imageSize.rawValue, alignment: .center)
                            .scaleEffect(AppValueConstants.Numeric.progressViewScale5.rawValue)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
        }
    }
    
    // MARK: - Private
    
    /// Setup the columns for ingredient and measurement
    @ViewBuilder
    private func ingredientAndMeasurement(_ ingredient: String?, _ measurement: String?) -> some View {
        if let ingr = ingredient, let meas = measurement,
           ingr != "", meas != "" {
            HStack {
                Text(ingr)
                    .font(.system(size: AppValueConstants.Numeric.fontSize12.rawValue))
                    .minimumScaleFactor(AppValueConstants.Numeric.textMinSCale05.rawValue)
                    .padding()
                Spacer()
                Text(meas)
                    .font(.system(size: AppValueConstants.Numeric.fontSize12.rawValue))
                    .minimumScaleFactor(AppValueConstants.Numeric.textMinSCale05.rawValue)
                    .padding()
            }
        } 
    }
    
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(mealDetailViewModel: MealDetailViewModel())
    }
}
