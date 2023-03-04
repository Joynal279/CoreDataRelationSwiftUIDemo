//
//  PersistenceController.swift
//  CoreDataRelationSwiftUIDemo
//
//  Created by Joynal Abedin on 4/3/23.
//

import CoreData
import SwiftUI

struct PersistenceContrller {
    static let shared = PersistenceContrller()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Products")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Container load failed \(error)")
            }
        }
    }
    
    
}
