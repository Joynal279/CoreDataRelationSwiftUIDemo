//
//  CoreDataRelationSwiftUIDemoApp.swift
//  CoreDataRelationSwiftUIDemo
//
//  Created by Joynal Abedin on 4/3/23.
//

import SwiftUI

@main
struct CoreDataRelationSwiftUIDemoApp: App {
    
    let persistenceController = PersistenceContrller.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
