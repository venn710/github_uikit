//
//  ApiCall.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 16/05/24.
//

import Foundation
protocol ApiCall {
    var endPoint: String { get }
    var method: String { get }
    var headers: [String : String] { get }
    var body: Data? { get }
}

extension ApiCall {
    
    private var baseURL: String {
        "https://api.github.com"
    }
    func getUrlRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + endPoint) else {
            throw ApiError.invalidUrl
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
