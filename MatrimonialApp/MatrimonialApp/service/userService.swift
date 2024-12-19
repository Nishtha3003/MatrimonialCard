//
//  userService.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import Foundation

class UserService {
    private let client = WebClient(baseUrl: baseUrl())
    public static let shared = UserService()
    
    private init() {}

    func getProfileList(completion: @escaping (UserResponse?, ServiceError?) -> Void, resultQuery: Int) {
        let query = ["results": String(resultQuery)]
        client.request(
            path: "api/",
            method: .get,
            query: query,
            completion: { result in
                switch result {
                case .success(let responseData):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust if needed
                        let userResponse = try decoder.decode(UserResponse.self, from: responseData.data!)
                        completion(userResponse, nil)
                    } catch {
                        completion(nil, .parsingError(error.localizedDescription))
                    }
                case .failure(let serviceError):
                    completion(nil, serviceError)
                }
            }
        )
    }
}
