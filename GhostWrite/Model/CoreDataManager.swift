//
//  CoreDataManager.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/8/25.
//

import Foundation
import CoreData

// Define an observable class to encapsulate all Core Data-related functionality.
class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "CoreModelSet")
        
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    private init() { }
}

extension CoreDataStack {
    // Save changes in the context if there are any.
    func save() {
        guard persistentContainer.viewContext.hasChanges else { return }
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    // Delete a ShoppingItem and save the context.
    func delete<T: NSManagedObject>(item: T) {
           persistentContainer.viewContext.delete(item)
           save()
       }
}
