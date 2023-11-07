//
//  SpaceTraders_ClientApp.swift
//  SpaceTraders Client
//
//  Created by Ethan Silver on 2023-11-06.
//

import SwiftUI
import SwiftData

@main
struct SpaceTraders_ClientApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
