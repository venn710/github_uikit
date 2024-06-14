//
//  GFUserRepoInfoVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 02/06/24.
//

import UIKit

class GFUserRepoInfoVC: GFUserInfoItemVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }

    weak var delegate: GFUserRepoInfoVCDelegate?
    
    private func configureVC() {
        userInfoItem1.setUpInfoItem(using: .repos, with: userDetails.publicRepos)
        userInfoItem2.setUpInfoItem(using: .gists, with: userDetails.publicGists)
        
        buttonView.set(color: .systemPurple, title: "GitHub Profile", systemImageName: "person")
        buttonView.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
    }
    
    @objc func handleProfile() {
        delegate?.tapOnProfile(for: userDetails)
    }
    
}
