//
//  PersistenceController.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/28/23.
//

import CoreData
import Foundation

/// CoreData data controller
struct PersistenceController {
    
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)

        // Create 10 example meals
        for _ in 0..<10 {
            let meal = FavoriteMeals(context: result.container.viewContext)
            meal.idMeal =  "1"
            meal.strMeal = "Meal One"
            meal.strMealThumb = "MealPic"
        }

        return result
    }()

    // An initializer to load Core Data, optionally able to use an in-memory store.
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: AppValueConstants.CoreDataConfig.containerName.rawValue)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Save the data that has just been added
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
                // It can be a reactive send error to the root view
            }
        }
    }
    
}
