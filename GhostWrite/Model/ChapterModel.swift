//
//  ChapterModel.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/14/25.
//

import Foundation

struct ChapterModel : Encodable {
    let name: String
    let content: String
    var embedding: Data? = nil
}
