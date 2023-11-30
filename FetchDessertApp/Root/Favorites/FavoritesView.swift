//
//  FavoritesView.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import SwiftUI

// MARK: - This view needs no view model because it just facilitates the favorites list which is a global components that has all favorite actions within the meal detail views. This is also loaded by core data when app is first loaded.

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
                        Text(AppValueConstants.Labels.noFavorites.rawValue)
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
            refreshList(fromList: list)
        })
        
    }
    
    // MARK: - Methods
    
    /// - Note: Keeping this local because it needs local files and is only on method here
    
    /// Refresh list when a new one is received
    /// - Parameter list: Updated favorites list
    private func refreshList(fromList list: [Int: Meal]) {
        loading = true
        meals = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
            meals = list.map{ $1 }
            meals?.sort { $0.strMeal < $1.strMeal }
            loading = false
            print(AppValueConstants.Logs.favoriteListUpdated.rawValue)
            
        })
    }
    
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(meals: [])
    }
}
