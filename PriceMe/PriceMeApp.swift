//
//  PriceMeApp.swift
//  PriceMe
//
//  Created by Anmay Gupta on 12/10/21.
//

import SwiftUI

@main
struct PriceMeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
