//
//  ApiError.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 16/05/24.
//

import Foundation

enum ApiError: String, Error {
    case invalidUrl = "URL is not valid"
    case inValidResponse = "Api response is invalid"
    case decodingError = "Unable to decode the Api response"
    case userIsNotAvailable = "No user exists, Please check the username again"
    case somethingWentWrong = "Something went wrong, please try again"
    case unableToFavouriteUser = "Unable to favourite this user, Please try again"
    case unableToRetrieveFollowers = "Unable to retrieve followers, Please try again"
    case alreadyInFavourites = "User is already in favourites"
}
