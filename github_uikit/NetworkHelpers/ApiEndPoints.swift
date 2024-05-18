//
//  ApiEndPoints.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 16/05/24.
//

import Foundation
enum ApiEndPoints {
    case getFollowers(userName: String, page: Int)
}

extension ApiEndPoints: ApiCall {

    var endPoint: String {
        switch self {
        case .getFollowers(let userName, let page):
            return "/users/\(userName)/followers?per_page=100&page=\(page)"
        }
    }
    
    var method: String {
        switch self {
        case .getFollowers:
            return "get"
        }
    }
    
    var headers: [String : String] {
        var headers: [String : String] = [:]
        headers["Accept"] = "application/vnd.github+json"
        return headers
    }
    
    var body: Data? {
        nil
    }
}
