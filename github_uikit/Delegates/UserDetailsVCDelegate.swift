//
//  UserDetailsVCDelegate.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 03/06/24.
//

import Foundation

protocol UserDetailsVCDelegate: AnyObject {
    func didRequestFollowers(for user: User)
}
