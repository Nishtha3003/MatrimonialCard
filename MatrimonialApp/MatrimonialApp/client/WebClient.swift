//
//  WebClient.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import Foundation

final class WebClient {
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func request(
        path: String,
        method: RequestMethod,
        query: [String: String]? = nil,
        body: Data? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<ResponseData, ServiceError>) -> Void
    ) {
        guard let url = buildURL(path: path, query: query) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            let responseData = ResponseData(
                data: data,
                statusCode: httpResponse.statusCode,
                headers: httpResponse.allHeaderFields
            )

            if (200..<300).contains(httpResponse.statusCode) {
                completion(.success(responseData))
            } else {
                completion(.failure(.httpError(responseData)))
            }
        }

        task.resume()
    }

    private func buildURL(path: String, query: [String: String]?) -> URL? {
        var components = URLComponents(string: baseUrl + path)
        if let query = query {
            components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        return components?.url
    }
}

struct ResponseData: Equatable {
    let data: Data?
    let statusCode: Int
    let headers: [AnyHashable: Any]
    
    static func == (lhs: ResponseData, rhs: ResponseData) -> Bool {
        // Compare data, statusCode, and headers
        return lhs.statusCode == rhs.statusCode &&
            lhs.data == rhs.data &&
            NSDictionary(dictionary: lhs.headers).isEqual(to: rhs.headers)
    }
}

enum ServiceError: Error, Equatable {
    case invalidURL
    case networkError(String)
    case invalidResponse
    case httpError(ResponseData)
    case parsingError(String)

    static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.networkError, .networkError),
             (.invalidResponse, .invalidResponse),
             (.httpError, .httpError):
            return true
        case let (.parsingError(lhsMsg), .parsingError(rhsMsg)):
            return lhsMsg == rhsMsg
        default:
            return false
        }
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
