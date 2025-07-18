//
//  SettingView.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/8/25.
//

import SwiftUI
import CoreData

struct SettingView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch all Location entities, sorted by name

        // Save only if no location with the same name exists
        func saveLocation(name: String, lore: String) {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Location")
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            fetchRequest.fetchLimit = 1

            do {
                let count = try viewContext.count(for: fetchRequest)
                if count == 0 {
                    let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: viewContext)
                    location.setValue(name, forKey: "name")
                    location.setValue(lore, forKey: "lore")
                    CoreDataStack.shared.save()
                } else {
                    print("Location with this name already exists.")
                }
            } catch {
                print("Failed to check for duplicate location:", error.localizedDescription)
            }
        }
    
    func printLocations() {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Location")
        do {
            let locations = try viewContext.fetch(fetchRequest)
            for location in locations {
                let name = location.value(forKey: "name") as? String ?? "Unknown"
                let lore = location.value(forKey: "lore") as? String ?? "No lore"
                print("Location: \(name), Lore: \(lore)")
            }
        } catch {
            print("Failed to fetch locations:", error.localizedDescription)
        }
    }
    
    
    
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                Text("Locations")
                    .font(.largeTitle)
                Button("Print Locations") {
                    printLocations()
                }
                
                Button("Save Locations") {
                    saveLocation(name: "New Location", lore: "This is a new location.")
                }
                
            }
        }
    }
}

