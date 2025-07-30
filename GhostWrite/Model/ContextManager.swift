//
//  ContextManager.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/21/25.
//

import Foundation
import CoreData

class ContextManager {
    
    private let embeddingService: EmbeddingService
    private let coreDataStack: CoreDataStack
    
    init(embeddingService: EmbeddingService = EmbeddingService(), coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.embeddingService = embeddingService
        self.coreDataStack = coreDataStack
    }
    
    func cosineSimilarity(_ vectorA: [Double], _ vectorB: [Double]) -> Double {
        let dotProduct = zip(vectorA, vectorB).map(*).reduce(0, +)
        let magnitudeA = sqrt(vectorA.map { $0 * $0 }.reduce(0, +))
        let magnitudeB = sqrt(vectorB.map { $0 * $0 }.reduce(0, +))
        return dotProduct / (magnitudeA * magnitudeB)
    }
    
    func findRelevantContexts(_ prompt: String) async throws {
        
    }
    
    func addContext(_ context: [String]) {
        // given the relevant context, prepare the query for the LLM
    }
}
