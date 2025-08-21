import Foundation
import CoreData

struct ChapterModel: Encodable {
    let name: String
    let content: String
    var embedding: Data? = nil

    var context: String {
        """
        Name: \(name)
        Content: \(content)
        """
    }

    init?(entity: NSManagedObject) {
        guard
            let name = entity.value(forKey: "name") as? String,
            let content = entity.value(forKey: "content") as? String
        else {
            return nil
        }
        self.name = name
        self.content = content
    }

    init(name: String, content: String) {
        self.name = name
        self.content = content
    }

    init() {
        self.name = ""
        self.content = ""
    }

    func changeOneAttribute(_ attribute: String, value: String) -> ChapterModel {
        switch attribute {
        case "name":
            return ChapterModel(name: value, content: self.content)
        case "content":
            return ChapterModel(name: self.name, content: value)
        default:
            return self
        }
    }
}
