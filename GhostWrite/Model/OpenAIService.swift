//
//  GPTService.swift
//  GhostWrite
//
//  Created by Robert Fusting on 7/20/25.
//

import Foundation

struct OpenAIChatRequest: Codable {
    let model: String
    let messages: [Message]
}

struct Message: Codable {
    let role: String // "user", "assistant", or "system"
    let content: String
}

struct OpenAIChatResponse: Codable {
    struct Choice: Codable {
        let message: Message
    }
    let choices: [Choice]
}

class OpenAIService {
    static let shared = OpenAIService()
    private init() {}
    private var apiKey: String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
            let key = plist["OPENAI_API_KEY"] as? String
        else {
            print("API key not found in Secrets.plist")
            return ""
        }
        return key
    }
    
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(prompt: String) async throws -> String? {
        let messages = [Message(role: "user", content: prompt)]
        let requestBody = OpenAIChatRequest(model: "gpt-3.5-turbo", messages: messages)

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        let data = try JSONEncoder().encode(requestBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (responseData, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP status code:", httpResponse.statusCode)
        }
        
        let decoded = try JSONDecoder().decode(OpenAIChatResponse.self, from: responseData)
        return decoded.choices.first?.message.content
    }
}
