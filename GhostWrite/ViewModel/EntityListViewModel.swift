//
//  EntityListViewModel.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/28/25.
//

import Foundation
import CoreData

class EntityListViewModel: ObservableObject {
    //basically what I want is to hold all of the data for a generic entity list view
    //and I can use this to create settingView, MagicView, and characterView
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    @Published var fetchedResults: [NSManagedObject] = []
    @Published var workingEntity: WorkingEntity?
    
    enum WorkingEntity {
        case location(LocationModel)
        case magic(MagicModel)
        case character(CharacterModel)
    }
    
    func fetchEntities(_ entity: String) {
        fetchedResults = coreDataStack.fetchAllRecords(entityName: entity)
    }
    
    
    func saveEntity(_ entity: WorkingEntity) {
    }
}

