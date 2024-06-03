//
//  GFUserFollowerInfoVCDelegate.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 03/06/24.
//

import Foundation

protocol GFUserFollowerInfoVCDelegate: AnyObject {
    func tapOnGetFollowers(for user: User)
}
