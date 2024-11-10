//
//  hp_triviaApp.swift
//  hp_trivia
//
//  Created by Joel Espinal on 27/10/24.
//

import SwiftUI

@main
struct hp_triviaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
               .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
