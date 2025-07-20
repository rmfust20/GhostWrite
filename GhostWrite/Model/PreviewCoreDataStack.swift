import SwiftUI
import CoreData

// Helper for preview Core Data stack
class PreviewCoreDataStack {
    static let shared: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreModelSet") // Replace with your .xcdatamodeld name
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Preview store error: \(error)")
            }
        }
        return container
    }()
}

