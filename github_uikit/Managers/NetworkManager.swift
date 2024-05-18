//
//  NetworkManager.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 16/05/24.
//

import Foundation

final class NetworkManager {    
    static let shared: NetworkManager = NetworkManager()
    private init() {}
    
    func makeAPICall<T: Codable>(apiCall: ApiCall) async -> Result<T, ApiError> {
        do {
            let urlRequest = try apiCall.getUrlRequest()
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                throw ApiError.inValidResponse
            }
            if urlResponse.statusCode == 404 {
                throw ApiError.userIsNotAvailable
            }
            guard urlResponse.statusCode == 200 else {
                throw ApiError.inValidResponse
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try? jsonDecoder.decode(T.self, from: data)
            guard let decodedData = decodedData else {
                throw ApiError.decodingError
            }
            return .success(decodedData)
        } catch {
            if let _error = error as? ApiError {
                return .failure(_error)
            } else {
                return .failure(.somethingWentWrong)
            }
        }
    }
}
