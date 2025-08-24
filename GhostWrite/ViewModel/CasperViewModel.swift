//
//  CasperViewModel.swift
//  GhostWrite
//
//  Created by Robert Fusting on 8/18/25.
//

import Foundation

class CasperViewModel: ObservableObject {
    private let contextManager: ContextManager
    
    init(contextManager: ContextManager = ContextManager.shared) {
        self.contextManager = contextManager
    }
    
    @Published var promptText: String = ""
    @Published var responseText: String?
    @Published var previousConverstations: [String: String] = [:]
    
    @MainActor
    func generateResponse(_ query: String) async -> String?{
        let response = await contextManager.generatePrompt(query: query, pastConversations: previousConverstations)
        saveConversation(query: query, response: response ?? "")
        return response
    }
    
    func saveConversation(query: String, response: String) {
        previousConverstations[query] = response
    }
}
