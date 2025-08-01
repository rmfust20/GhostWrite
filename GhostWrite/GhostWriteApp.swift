//
//  GhostWriteApp.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/8/25.
//

import SwiftUI

@main
struct GhostWriteApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            LandingView()
            
                .environment(\.managedObjectContext,
                                              coreDataStack.persistentContainer.viewContext)
        }
    }
}
