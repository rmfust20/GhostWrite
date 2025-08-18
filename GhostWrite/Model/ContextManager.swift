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
    
    func cosineSimilarity(_ vectorA: [Float], _ vectorB: [Float]) -> Float {
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
    
    func grabRelevantContext(query: String) async throws -> [NSManagedObject] {
        //To do this we need to retrieve all of the embeddings from the database
        //Then we will compare the embeddings of the query to the embeddings in the database
        //We will use cosine similarity to find the most relevant embeddings
        //Then we will return the top N embeddings that are most relevant to the query
        
        let queryEmbedding = try? await embeddingService.embed(query)
        
        let entityList = ["Chapter", "Character", "Magic", "Location"]
        var records: [[NSManagedObject]] = [[]]
        var topEmbeddings: [(Float, NSManagedObject)] = []
        
        for entity in entityList {
            records.append(coreDataStack.fetchAllRecords(entityName: entity))
        }
        
        // Now we have all the records for each entity type
        // We will iterate through each record and calculate the cosine similarity with the query embedding
        for recordList in records {
            for record in recordList {
                if let embedding = record.value(forKey: "embedding") as? Data {
                    let embeddingArray = try? JSONDecoder().decode([Float].self, from: embedding)
                    let similarity = cosineSimilarity(queryEmbedding ?? [0.0], embeddingArray ?? [0.0])
                    if topEmbeddings.count < 5 {
                        topEmbeddings.append((similarity, record))
                    } else if let minIndex = topEmbeddings.enumerated().min(by: { $0.element.0 < $1.element.0 })?.offset,
                              similarity > topEmbeddings[minIndex].0 {
                        topEmbeddings[minIndex] = (similarity, record)
                    }
                }
                
            }
        }
        
        //now topEmbeddings has the top 5 most relevant embeddings, let's return just the actual records
        return topEmbeddings.map { $0.1 }
    }
    
    func generatePrompt(query: String) async -> String?{
        //Given a list of relevant embeddings, we will generate a prompt
        let relevantContext: [NSManagedObject]? = try? await grabRelevantContext(query: query)
        
        if let context = relevantContext {
            var contextAsString = ""
            context.forEach {record in
                contextAsString += record.value(forKey: "context") as? String ?? "" + "\n\n"
            }
            
            let prompt = "You are a fantasy novel editor. Given the following context, please do one of the following tasks based on the user's query. 1: Answer the user's query based on the context. 2: Generate a new piece of content based on the context. 3: Provide feedback on the context. 4: Help the user brainstorm new ideas based on the context. 5: Rewrite the users query to help improve their writing. 6: If you are not sure what to do or the context is not relevant, answer to the best of your ability but do not make up any information about the context that isn't true. Here is the context:\n\n\(contextAsString)\n\n Here is the user's query: \(query)"
            
            return try? await gptService.sendMessage(prompt: prompt)
        }
        
    
        return try? await gptService.sendMessage(prompt: query)
        
    }
}
