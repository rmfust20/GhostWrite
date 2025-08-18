import Foundation
import CoreData

struct CharacterModel: Encodable {
    let name: String
    let backstory: String
    let motivation: String
    let personality: String
    var context: String {
        """
        Name: \(name)
        Backstory: \(backstory)
        Motivation: \(motivation)
        Personality: \(personality)
        """
    }
    
    var embedding: Data? = nil

    init?(entity: NSManagedObject) {
        guard
            let name = entity.value(forKey: "name") as? String,
            let backstory = entity.value(forKey: "backstory") as? String,
            let motivation = entity.value(forKey: "motivation") as? String,
            let personality = entity.value(forKey: "personality") as? String
        else {
            return nil
        }
        self.name = name
        self.backstory = backstory
        self.motivation = motivation
        self.personality = personality
    }

    init(name: String, backstory: String, motivation: String, personality: String) {
        self.name = name
        self.backstory = backstory
        self.motivation = motivation
        self.personality = personality
    }
    
    init() {
        self.name = ""
        self.backstory = ""
        self.motivation = ""
        self.personality = ""
    }

    func changeOneAttribute(_ attribute: String, value: String) -> CharacterModel {
        switch attribute {
        case "name":
            return CharacterModel(name: value, backstory: self.backstory, motivation: self.motivation, personality: self.personality)
        case "backstory":
            return CharacterModel(name: self.name, backstory: value, motivation: self.motivation, personality: self.personality)
        case "motivation":
            return CharacterModel(name: self.name, backstory: self.backstory, motivation: value, personality: self.personality)
        case "personality":
            return CharacterModel(name: self.name, backstory: self.backstory, motivation: self.motivation, personality: value)
        default:
            return self
        }
    }
}
