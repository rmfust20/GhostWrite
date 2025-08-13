//
//  ContextManager.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/21/25.
//

import Foundation
import CoreData

class ContextManager {
    static let shared = ContextManager()
    private let embeddingService: EmbeddingService
    private let coreDataStack: CoreDataStack
    private let gptService: OpenAIService = OpenAIService.shared
    
    private init(embeddingService: EmbeddingService = EmbeddingService.shared, coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.embeddingService = embeddingService
        self.coreDataStack = coreDataStack
    }
    
    func cosineSimilarity(_ vectorA: [Double], _ vectorB: [Double]) -> Double {
        let dotProduct = zip(vectorA, vectorB).map(*).reduce(0, +)
        let magnitudeA = sqrt(vectorA.map { $0 * $0 }.reduce(0, +))
        let magnitudeB = sqrt(vectorB.map { $0 * $0 }.reduce(0, +))
        return dotProduct / (magnitudeA * magnitudeB)
    }
    
    func createSummaryAsEmbedding(model : String) async throws -> [Float]? {
        let prompt = "You are a working on a RAG pipeline. Summarize the following model in a concise way that is optimal for semantic understanding and retrival. Do not include any extraneous information. Your response should only be a short summary of the model. Here is the model:\n\n\(model)"
        
        let response = try await gptService.sendMessage(prompt: prompt)
        
        if let validResponse = response {
            let summary = try await embeddingService.embed(validResponse)
            return summary
        }
        return nil
    }
    
    func grabRelevantContext() {
        
    }
    
    func generatePrompt()  {
        //this is the G in RAG
    }
}
