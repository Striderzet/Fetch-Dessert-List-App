//
//  FetchDessertAppApp.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import SwiftUI

@main
struct FetchDessertAppApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase, perform: { _ in
            persistenceController.save()
        })
    }
    
}
