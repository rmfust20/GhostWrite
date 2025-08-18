import Foundation
import CoreData

struct MagicModel: Encodable {
    let name: String
    let abilities: String
    let limitations: String
    var context: String {
        """
        Name: \(name)
        Abilities: \(abilities)
        Limitations: \(limitations)
        """
    }
    
    var embedding: Data? = nil

    init?(entity: NSManagedObject) {
        guard
            let name = entity.value(forKey: "name") as? String,
            let abilities = entity.value(forKey: "abilities") as? String,
            let limitations = entity.value(forKey: "limitations") as? String
        else {
            return nil
        }
        self.name = name
        self.abilities = abilities
        self.limitations = limitations
    }

    init(name: String, abilities: String, limitations: String) {
        self.name = name
        self.abilities = abilities
        self.limitations = limitations
    }
    
    init() {
        self.name = ""
        self.abilities = ""
        self.limitations = ""
    }

    func changeOneAttribute(_ attribute: String, value: String) -> MagicModel {
        switch attribute {
        case "name":
            return MagicModel(name: value, abilities: self.abilities, limitations: self.limitations)
        case "abilities":
            return MagicModel(name: self.name, abilities: value, limitations: self.limitations)
        case "limitations":
            return MagicModel(name: self.name, abilities: self.abilities, limitations: value)
        default:
            return self
        }
    }
}
