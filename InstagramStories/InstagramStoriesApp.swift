//
//  InstagramStoriesApp.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import SwiftUI
import SwiftData

@main
struct InstagramStoriesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            StoryState.self,
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
            let dataManager = StoryDataManagerImp(modelContext: sharedModelContainer.mainContext)
            StoryListView(
                dataManager: dataManager,
                commandFactory: StoryCommandFactoryImp(dataManager: dataManager)
            )
            .modelContainer(sharedModelContainer)
                
        }
        
    }
}
