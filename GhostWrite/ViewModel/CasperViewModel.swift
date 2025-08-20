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
    
    @MainActor
    func generateResponse(_ query: String) async -> String?{
        return await contextManager.generatePrompt(query: query)
    }
}
