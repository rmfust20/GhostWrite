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
    
    @Published var entityType: String = ""
    @Published var fetchedResults: [NSManagedObject] = []
    @Published var workingEntity: NSManagedObject?
    @Published var workingModel: WorkingModelEnum?
    
    enum WorkingModelEnum {
        case location(LocationModel)
        case magic(MagicModel)
        case character(CharacterModel)
    }
    
    func setWorkingEntity(_ entity: NSManagedObject?) {
        self.workingEntity = entity
    }
    
    func setEntityType(_ type: String) {
        self.entityType = type
    }
    
    func constructModelFromText(text: String, attribute: String) {
        //first check if workingModel is nil
        
        switch entityType {
        case "Location":
            if workingModel == nil {
                let locationModel = LocationModel()
                workingModel = .location(locationModel.changeOneAttribute(attribute, value: text))
            }
            else {
                if case let .location(locationModel) = workingModel {
                    workingModel = .location(locationModel.changeOneAttribute(attribute, value: text))
                }
                    
            }
        case "Magic":
            if workingModel == nil {
                let magicModel = MagicModel()
                workingModel = .magic(magicModel.changeOneAttribute(attribute, value: text))
            }
            else {
                if case let .magic(magicModel) = workingModel {
                    workingModel = .magic(magicModel.changeOneAttribute(attribute, value: text))
                    
                }
            }
        case "Character":
            if workingModel == nil {
                let characterModel = CharacterModel()
                workingModel = .character(characterModel.changeOneAttribute(attribute, value: text))
            }
            else {
                if case let .character(characterModel) = workingModel {
                    workingModel = .character(characterModel.changeOneAttribute(attribute, value: text))
                }
            }
        default :
            print("Unknown entity type: \(entityType)")
        }
    }
    
    func unWrapWorkingModel() -> Encodable {
        switch workingModel {
        case .location(let locatioModel):
            return locatioModel
        case .magic(let magicModel):
            return magicModel
        case .character(let characterModel):
            return characterModel
        default:
            return LocationModel() // or some default model
        }
    }
        
        
    
    
    func fetchEntities(_ entity: String) {
        self.fetchedResults = coreDataStack.fetchAllRecords(entityName: entity)
    }
    
    func updateEntity(text: String, attribute: String) {
        constructModelFromText(text: text, attribute: attribute)
        guard let dict = try? unWrapWorkingModel().asDictionary() else { return }
        if let workingEntity = workingEntity {
            workingEntity.setValuesForKeys(dict)
            coreDataStack.save()
        }
    }
    
    func saveEntity(text: String, attribute: String, name: String) {
        constructModelFromText(text: text, attribute: attribute)
        let fetchedRecord = coreDataStack.fetchRecord(entityName: entityType, name: name)
        if fetchedRecord == nil {
            let context = coreDataStack.persistentContainer.viewContext
            let newObject = NSEntityDescription.insertNewObject(forEntityName: entityType, into: context)
            if let dict = try? unWrapWorkingModel().asDictionary() {
                newObject.setValuesForKeys(dict)
                coreDataStack.save()
            }
        }
    }
}

