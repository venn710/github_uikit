//
//  FollowerCell.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 17/05/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reUseId = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(titleTextAlignment: .center, titleTextColor: .systemCyan, titleFontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        userNameLabel.text = follower.login
        Task {
            await avatarImageView.downloadImage(from: follower.avatarUrl)
        }
    }
    
    private func configure() {
        addSubViews(avatarImageView, userNameLabel)
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        translatesAutoresizingMaskIntoConstraints = false
    }
}
