//
//  CardItem.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/5/25.
//

import Foundation

struct CardItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let systemImage: String
}
