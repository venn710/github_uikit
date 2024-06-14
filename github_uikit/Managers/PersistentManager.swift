//
//  PersistentManager.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 06/06/24.
//

import Foundation

struct PersistentManager {
    
    private let defaultStorage = UserDefaults.standard
    private init() {}
    static var shared: PersistentManager = PersistentManager()
    
    enum UpdationType {
        case add
        case delete
    }
    
    enum Keys: String {
        case favourites = "favourites"
    }
}

extension PersistentManager {
    func save(with followers: [Follower]) -> ApiError? {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(followers)
            defaultStorage.setValue(encodedData, forKey: Keys.favourites.rawValue)
            return nil
        } catch {
            return .unableToFavouriteUser
        }
    }
    
    func modify(favourite: Follower, type: UpdationType) -> ApiError? {
        let result: Result<[Follower], ApiError> = retrieve()
        switch result {
        case .success(let success):
            var followers = success
            switch type {
            case .add:
                guard !followers.contains(favourite) else {
                    return .alreadyInFavourites
                }
                followers.append(favourite)
            case .delete:
                followers.removeAll(where: { $0.login == favourite.login })
            }
            return save(with: followers)
            
        case .failure:
            return .unableToRetrieveFollowers
        }
    }
    
    func retrieve() -> Result<[Follower], ApiError> {
        let retrievedData: Data? = defaultStorage.object(forKey: Keys.favourites.rawValue) as? Data
        guard let retrievedData else {
            return .success([])
        }
        let decoder: JSONDecoder = JSONDecoder()
        do {
            let decodedData: [Follower] = try decoder.decode([Follower].self, from: retrievedData)
            return .success(decodedData)
        } catch {
            return .failure(.unableToRetrieveFollowers)
        }
    }
}
