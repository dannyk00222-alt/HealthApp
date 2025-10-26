//
//  HealthAppApp.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//

import SwiftUI
import CoreData

@main
struct HealthAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
