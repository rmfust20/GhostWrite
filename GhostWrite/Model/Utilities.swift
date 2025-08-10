//
//  Utilities.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/31/25.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data)
        guard let dict = json as? [String: Any] else {
            throw NSError(domain: "ModelConversion", code: 0, userInfo: nil)
        }
        return dict
    }
}

