//
//  FavoritesView.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import SwiftUI

struct FavoritesView: View {
    
    @State var meals: [Meal]?
    
    @State private var loading = false
    
    var body: some View {
        
        VStack {
        
            if let realMeals = self.meals,
               !realMeals.isEmpty {
                MealListComponent(meals: realMeals)
            } else {
                if !loading {
                    VStack(alignment: .center) {
                        Text("No Favorites at the Moment")
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
        .onReceive(ReactivePublisher.shared.favoritesList, perform: { list in
            
            loading = true
            meals = nil
            
            /// - Note: This is a workaround and i don't like it
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                meals = list.map{ $1 }
                meals?.sort { $0.strMeal < $1.strMeal }
                loading = false
                print("Fave list updated: \(String(describing: meals))")
            })
            
        })
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(meals: [])
    }
}
