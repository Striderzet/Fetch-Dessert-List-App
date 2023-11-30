//
//  RootView.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/21/23.
//

import CoreData
import SwiftUI

struct RootView: View {
    
    //Fetch data at load time
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteMeals.idMeal, ascending: true)],
        animation: .default)
    
    var favorites: FetchedResults<FavoriteMeals>
    // End Fetch
    
    // This lives here to receive all important communications
    private let reactiveSubscriber = ReactiveSubscriber()
    
    // Always check and publish reachability changes as long as app is active
    private let networkReachabilityMonitor = NetworkReachabilityMonitor()
    
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
        .onAppear(perform: {
            loadAllData()
        })
    }
    
    // MARK: - Lifecycle start methods
    
    /// Load all needed data to app
    private func loadAllData() {
        // Load data for saved favorites list
        DataController.loadFavorites(fromList: favorites)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
