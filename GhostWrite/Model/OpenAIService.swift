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
    let temperature: Double?
    let max_tokens: Int?
    let top_p: Double?
}

struct Message: Codable {
    let role: String // "system" | "user" | "assistant"
    let content: String
}

struct OpenAIChatResponse: Codable {
    struct Choice: Codable {
        let index: Int?
        let message: Message
        let finish_reason: String?
    }
    let choices: [Choice]
    let usage: Usage?
    
    struct Usage: Codable {
        let prompt_tokens: Int?
        let completion_tokens: Int?
        let total_tokens: Int?
    }
}

struct OpenAIErrorResponse: Codable, Error {
    struct APIError: Codable {
        let message: String
        let type: String?
        let code: String?
    }
    let error: APIError
}

final class OpenAIService {
    static let shared = OpenAIService()
    private init() {}

    private var apiKey: String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
            let key = plist["OPENAI_API_KEY"] as? String
        else {
            assertionFailure("API key not found in Secrets.plist")
            return ""
        }
        return key
    }

    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!

    /// Convenience wrapper for a single user prompt
    func sendMessage(
        prompt: String,
        model: String = "gpt-4o-mini",
        temperature: Double = 0.3,
        maxTokens: Int? = nil
    ) async throws -> String? {
        let msgs = [Message(role: "user", content: prompt)]
        return try await sendMessages(
            messages: msgs,
            model: model,
            temperature: temperature,
            maxTokens: maxTokens
        )
    }

    /// Main entry: send an array of chat `messages` with roles.
    func sendMessages(
        messages: [Message],
        model: String = "gpt-4o-mini",
        temperature: Double = 0.3,
        maxTokens: Int? = nil,
        topP: Double? = nil,
        timeout: TimeInterval = 60
    ) async throws -> String? {

        let body = OpenAIChatRequest(
            model: model,
            messages: messages,
            temperature: temperature,
            max_tokens: maxTokens,
            top_p: topP
        )

        var request = URLRequest(url: endpoint, timeoutInterval: timeout)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        // Handle non-2xx with OpenAI error payload if present
        guard (200...299).contains(http.statusCode) else {
            if let apiErr = try? JSONDecoder().decode(OpenAIErrorResponse.self, from: data) {
                throw apiErr
            }
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(OpenAIChatResponse.self, from: data)
        return decoded.choices.first?.message.content
    }
}

