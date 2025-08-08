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
    @Published var workingEntity: NSManagedObject?
    @Published var workingModel: Encodable?
    
    enum WorkingEntity {
        case location(LocationModel)
        case magic(MagicModel)
        case character(CharacterModel)
    }
    
    func setWorkingEntity(_ entity: NSManagedObject?) {
        self.workingEntity = entity
    }
    
    
    func fetchEntities(_ entity: String) {
        self.fetchedResults = coreDataStack.fetchAllRecords(entityName: entity)
    }
    
    private func updateEntity(_ entity: NSManagedObject) {
        guard let dict = try? workingModel!.asDictionary() else { return }
        entity.setValuesForKeys(dict)
        coreDataStack.save()
    }
    
    /*
    
    private func saveEntityHelper<T: Encodable>(entityName: String, model: T, name: String) {
        let fetchedRecord = coreDataStack.fetchRecord(entityName: entityName, name: name)
        if fetchedRecord == nil {
            let context = coreDataStack.persistentContainer.viewContext
            let newObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
            if let dict = try? model.asDictionary() {
                newObject.setValuesForKeys(dict)
                coreDataStack.save()
            }
        }
    }
     */
    
    /*

    func saveEntity(_ passedEntity: WorkingEntity) {
        switch passedEntity {
        case .location(let locationModel):
            saveEntityHelper(entityName: "Location", model: locationModel, name: locationModel.name)
        case .magic(let magicModel):
            saveEntityHelper(entityName: "Magic", model: magicModel, name: magicModel.name)
        case .character(let characterModel):
            saveEntityHelper(entityName: "Character", model: characterModel, name: characterModel.name)
        }
    }
     
     */
    
    func saveEntity() {
        
    }
    
}

