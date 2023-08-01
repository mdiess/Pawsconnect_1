//
//  pawsconnect_demoApp.swift
//  pawsconnect_demo
//
//  Created by Max Diess on 7/20/23.
//

import SwiftUI

@main
struct pawsconnect_demoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
