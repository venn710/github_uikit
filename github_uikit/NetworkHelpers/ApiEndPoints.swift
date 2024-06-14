//
//  ApiEndPoints.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 16/05/24.
//

import Foundation

enum ApiEndPoints {
    case getFollowers(userName: String, page: Int)
    case getUserData(login: String)
}

extension ApiEndPoints: ApiCall {
    var endPoint: String {
        switch self {
        case .getFollowers(let userName, let page):
            return "/users/\(userName)/followers?per_page=100&page=\(page)"
        case .getUserData(let login):
            return "/users/\(login)"
        }
    }
    
    var method: String {
        switch self {
        case .getFollowers:
            return "get"
        case .getUserData:
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
