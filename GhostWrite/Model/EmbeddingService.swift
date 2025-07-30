import Foundation

class EmbeddingService {
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

    func embed(_ text: String) async throws -> [Float]? {
        guard let url = URL(string: "https://api.openai.com/v1/embeddings") else {
            return nil
        }

        let body: [String: Any] = [
            "input": text,
            "model": "text-embedding-3-small"
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)

        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
           let dataArray = json["data"] as? [[String: Any]],
           let embedding = dataArray.first?["embedding"] as? [Double] {
            return embedding.map { Float($0) }
        } else {
            print("Unexpected API response format.")
            return nil
        }
    }
}
