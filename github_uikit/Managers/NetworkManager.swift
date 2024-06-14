//
//  NetworkManager.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 16/05/24.
//

import UIKit

final class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    let imageCache:NSCache = NSCache<NSString, UIImage>()
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
            
            // We can use this to convert to Dates directly from response so while defining in model also we can define it as a type Date instead of converting from String to Date again.
//            jsonDecoder.dateDecodingStrategy = .iso8601
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
    
    func downloadImage(from url: String) async -> Data? {
        guard let url = URL(string: url) else { return nil }
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else { return nil }
            return data
        } catch {
            return nil
        }
    }
}
