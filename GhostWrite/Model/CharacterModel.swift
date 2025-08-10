import Foundation
import CoreData

struct CharacterModel: Encodable {
    let name: String
    let backstory: String
    let motivation: String
    let personlity: String

    init?(entity: NSManagedObject) {
        guard
            let name = entity.value(forKey: "name") as? String,
            let backstory = entity.value(forKey: "backstory") as? String,
            let motivation = entity.value(forKey: "motivation") as? String,
            let personlity = entity.value(forKey: "personlity") as? String
        else {
            return nil
        }
        self.name = name
        self.backstory = backstory
        self.motivation = motivation
        self.personlity = personlity
    }

    init(name: String, backstory: String, motivation: String, personlity: String) {
        self.name = name
        self.backstory = backstory
        self.motivation = motivation
        self.personlity = personlity
    }
    
    init() {
        self.name = ""
        self.backstory = ""
        self.motivation = ""
        self.personlity = ""
    }

    func changeOneAttribute(_ attribute: String, value: String) -> CharacterModel {
        switch attribute {
        case "name":
            return CharacterModel(name: value, backstory: self.backstory, motivation: self.motivation, personlity: self.personlity)
        case "backstory":
            return CharacterModel(name: self.name, backstory: value, motivation: self.motivation, personlity: self.personlity)
        case "motivation":
            return CharacterModel(name: self.name, backstory: self.backstory, motivation: value, personlity: self.personlity)
        case "personlity":
            return CharacterModel(name: self.name, backstory: self.backstory, motivation: self.motivation, personlity: value)
        default:
            return self
        }
    }
}
