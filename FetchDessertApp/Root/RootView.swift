//
//  RootView.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            
            MealListView()
                .tabItem({
                    Image(systemName: "list.star")
                    Text("Recipes")
                })
            
            FavoritesView()
                .tabItem({
                    Image(systemName: "star")
                    Text("Favorites")
                })
            
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
