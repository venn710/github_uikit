//
//  GFUserFollowersInfoVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 02/06/24.
//

import UIKit

class GFUserFollowersInfoVC: GFUserInfoItemVC {

    weak var delegate: GFUserFollowerInfoVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }

    
    private func configureVC() {
        userInfoItem1.setUpInfoItem(using: .followers, with: userDetails.followers)
        userInfoItem2.setUpInfoItem(using: .following, with: userDetails.following)

        buttonView.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
        buttonView.addTarget(self, action: #selector(handleGetFollowers), for: .touchUpInside)
    }
    
    @objc func handleGetFollowers() {
        delegate?.tapOnGetFollowers(for: userDetails)
    }
}
