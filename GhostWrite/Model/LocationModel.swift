//
//  LocationModel.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/10/25.
//

import Foundation
import CoreData

struct LocationModel: Encodable {
    let name: String
    var architecture: String
    var importantPeople: String
    var history: String
    var culture: String
    var general: String
    
    init?(entity: NSManagedObject) {
        guard
            let name = entity.value(forKey: "name") as? String,
            let architecture = entity.value(forKey: "architecture") as? String,
            let importantPeople = entity.value(forKey: "importantPeople") as? String,
            let history = entity.value(forKey: "history") as? String,
            let culture = entity.value(forKey: "culture") as? String,
            let general = entity.value(forKey: "general") as? String
        else {
            return nil
        }
        self.name = name
        self.architecture = architecture
        self.importantPeople = importantPeople
        self.history = history
        self.culture = culture
        self.general = general
    }
    
    init(name: String, architecture: String, importantPeople: String, history: String, culture: String, general: String) {
        self.name = name
        self.architecture = architecture
        self.importantPeople = importantPeople
        self.history = history
        self.culture = culture
        self.general = general
    }
    
    init() {
        self.name = ""
        self.architecture = ""
        self.importantPeople = ""
        self.history = ""
        self.culture = ""
        self.general = ""
    }
    
    func changeOneAttribute(_ attribute: String, value: String) -> LocationModel {
        switch attribute {
        case "architecture":
            return LocationModel(
                name: self.name,
                architecture: value,
                importantPeople: self.importantPeople,
                history: self.history,
                culture: self.culture,
                general: self.general
            )
        case "importantPeople":
            return LocationModel(
                name: self.name,
                architecture: self.architecture,
                importantPeople: value,
                history: self.history,
                culture: self.culture,
                general: self.general
            )
        case "history":
            return LocationModel(
                name: self.name,
                architecture: self.architecture,
                importantPeople: self.importantPeople,
                history: value,
                culture: self.culture,
                general: self.general
            )
        case "culture":
            return LocationModel(
                name: self.name,
                architecture: self.architecture,
                importantPeople: self.importantPeople,
                history: self.history,
                culture: value,
                general: self.general
            )
        case "general":
            return LocationModel(
                name: self.name,
                architecture: self.architecture,
                importantPeople: self.importantPeople,
                history: self.history,
                culture: self.culture,
                general: value
            )
        default:
            return self
        }
    }
    
}
